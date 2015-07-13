package com.newgonzo.web.css.selectors
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.views.ICSSView;
	
	import org.w3c.css.sac.ISelector;
	import org.w3c.css.sac.ISimpleSelector;
	import org.w3c.css.sac.SelectorTypes;	

	public class ChildSelector extends DescendantSelector
	{
		public function ChildSelector(parent:ISelector, child:ISimpleSelector)
		{
			super(parent, child);
		}
		
		override public function match(view:ICSSView, node:*):Boolean
		{
			var parent:* = view.parent(node);
			
			if(parent)
			{
				return ancestor.match(view, parent) && selector.match(view, node);
			}
			
			return false;
		}
		
		override public function get type():int
		{
			return SelectorTypes.SAC_CHILD_SELECTOR;
		}
		
		override public function toCSSString(document:ICSSDocument):String
		{
			return ancestor.toCSSString(document) + " > " + selector.toCSSString(document);
		}
	}
}