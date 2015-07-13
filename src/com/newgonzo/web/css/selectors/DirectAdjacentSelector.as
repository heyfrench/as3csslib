package com.newgonzo.web.css.selectors
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.views.ICSSView;
	
	import org.w3c.css.sac.ISelector;
	import org.w3c.css.sac.ISiblingSelector;
	import org.w3c.css.sac.ISimpleSelector;
	import org.w3c.css.sac.SelectorTypes;	

	public class DirectAdjacentSelector extends AbstractSiblingSelector implements IExtendedSelector, ISiblingSelector
	{
		public function DirectAdjacentSelector(nodeType:int, child:ISelector, directAdjacent:ISimpleSelector)
		{
			super(nodeType, child, directAdjacent);
		}
		
		public function match(view:ICSSView, node:*):Boolean
		{
			var parent:* = view.parent(node);
			
			if(!parent || !simpleSelector.match(view, node))
			{
				return false;
			}
		
			var pos:int = view.childIndex(node) - 1;
			
			if(pos < 0)
			{
				return false;
			}
			
			var adjacent:* = view.child(parent, pos);
			
			return childSelector.match(view, adjacent);
		}

		public function get type():int
		{
			return SelectorTypes.SAC_DIRECT_ADJACENT_SELECTOR;
		}
		
		public function toCSSString(document:ICSSDocument):String
		{
			return childSelector.toCSSString(document) + " + " + simpleSelector.toCSSString(document);
		}
	}
}