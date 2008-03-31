package com.newgonzo.commons.css.dom
{
	import com.newgonzo.commons.css.sac.ISiblingSelector;
	import com.newgonzo.commons.css.sac.ISimpleSelector;
	import com.newgonzo.commons.css.sac.ISelector;
	import com.newgonzo.commons.css.sac.SelectorTypes;
	
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