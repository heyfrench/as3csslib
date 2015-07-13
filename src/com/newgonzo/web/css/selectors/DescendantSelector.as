package com.newgonzo.web.css.selectors
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.views.ICSSView;
	
	import org.w3c.css.sac.IDescendantSelector;
	import org.w3c.css.sac.ISelector;
	import org.w3c.css.sac.ISimpleSelector;
	import org.w3c.css.sac.SelectorTypes;	

	public class DescendantSelector extends AbstractDescendantSelector implements IExtendedSelector, IDescendantSelector
	{
		public function DescendantSelector(parent:ISelector, descendant:ISimpleSelector)
		{
			super(parent, descendant);
		}
		
		public function match(view:ICSSView, node:*):Boolean
		{
			if(!selector.match(view, node))
			{
				return false;
			}
			
			var parent:* = view.parent(node);
			
			while(parent)
			{
				if(ancestor.match(view, parent))
				{
					return true;
				}
				
				parent = view.parent(parent);
			}
			
			return false;
		}
		
		public function get type():int
		{
			return SelectorTypes.SAC_DESCENDANT_SELECTOR;
		}
		
		public function toCSSString(document:ICSSDocument):String
		{
			return ancestor.toCSSString(document) + " " + selector.toCSSString(document);
		}
	}
}