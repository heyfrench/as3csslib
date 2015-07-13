package com.newgonzo.web.css.selectors
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.views.ICSSView;
	
	import org.w3c.css.sac.ISelector;
	import org.w3c.css.sac.ISiblingSelector;
	import org.w3c.css.sac.ISimpleSelector;
	import org.w3c.css.sac.SelectorTypes;	

	public class SiblingSelector extends AbstractSiblingSelector implements IExtendedSelector, ISiblingSelector
	{
		public function SiblingSelector(nodeType:int, child:ISelector, sibling:ISimpleSelector)
		{
			super(nodeType, child, sibling);
		}
		
		public function match(view:ICSSView, node:*):Boolean
		{
			var parent:* = view.parent(node);
			
			if(!parent || !simpleSelector.match(view, node))
			{
				return false;
			}
			
			var pos:int = view.childIndex(node) - 1;
			var child:*;
			
			while(pos >= 0)
			{
				child = view.child(parent, pos);
				
				if(childSelector.match(view, child))
				{
					return true;
				}
				
				pos--;
			}
			
			return false;
		}

		public function get type():int
		{
			return SelectorTypes.SAC_GENERAL_SIBLING_SELECTOR;
		}
		
		public function toCSSString(document:ICSSDocument):String
		{
			return childSelector.toCSSString(document) + " ~ " + simpleSelector.toCSSString(document);
		}
	}
}