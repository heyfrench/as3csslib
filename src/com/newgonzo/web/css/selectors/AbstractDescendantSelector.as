package com.newgonzo.web.css.selectors
{

	
	import org.w3c.css.sac.ISelector;
	import org.w3c.css.sac.ISimpleSelector;	

	public class AbstractDescendantSelector
	{
		protected var ancestor:IExtendedSelector;
		protected var selector:IExtendedSelector;
		
		public function AbstractDescendantSelector(parent:ISelector, descendant:ISimpleSelector)
		{
			ancestor = parent as IExtendedSelector;
			selector = descendant as IExtendedSelector;
		}
		
		public function get specificity():uint
		{
			return ancestor.specificity + selector.specificity;
		}
		
		public function get ancestorSelector():ISelector
		{
			return ancestor;
		}
		
		public function get simpleSelector():ISimpleSelector
		{
			return selector;
		}
	}
}