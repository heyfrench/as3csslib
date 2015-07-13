package com.newgonzo.web.css.selectors
{

	
	import org.w3c.css.sac.ISelector;
	import org.w3c.css.sac.ISimpleSelector;	

	public class AbstractSiblingSelector
	{
		// Element, Comment, CDATA?
		private var xmlType:int;
		protected var childSelector:IExtendedSelector;
		protected var simpleSelector:IExtendedSelector;
		
		public function AbstractSiblingSelector(nodeType:int, child:ISelector, sibling:ISimpleSelector)
		{
			xmlType = nodeType;
			childSelector = child as IExtendedSelector;
			simpleSelector = sibling as IExtendedSelector;
		}
		
		public function get specificity():uint
		{
			return childSelector.specificity + simpleSelector.specificity;
		}
		
		public function get nodeType():int
		{
			return xmlType;
		}
		
		public function get selector():ISelector
		{
			return childSelector;
		}
		
		public function get siblingSelector():ISimpleSelector
		{
			return simpleSelector;
		}
	}
}