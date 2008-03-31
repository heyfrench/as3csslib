package com.newgonzo.commons.css.dom
{
	import com.newgonzo.commons.css.sac.IConditionalSelector;
	import com.newgonzo.commons.css.sac.ISimpleSelector;
	import com.newgonzo.commons.css.sac.ICondition;
	import com.newgonzo.commons.css.sac.SelectorTypes;
	
	public class ConditionalSelector implements IExtendedSelector, IConditionalSelector
	{
		private var selector:IExtendedSelector;
		private var selectorCondition:IExtendedCondition;
		
		public function ConditionalSelector(simpleSelector:ISimpleSelector, condition:ICondition)
		{
			selector = simpleSelector as IExtendedSelector;
			selectorCondition = condition as IExtendedCondition;
		}
		
		public function get simpleSelector():ISimpleSelector
		{
			return selector;
		}
		
		public function get condition():ICondition
		{
			return selectorCondition;
		}
		
		public function select(xml:XML):XMLList
		{
				var list:XMLList = selector.select(xml);
				
				var test:XML;
				var newList:XMLList = new XMLList();
				
				for each(test in list)
				{	
					if(selectorCondition.match(test))
					{
						newList += test;		
					}
				}
				
				return newList;
		}
		
		public function get type():int
		{
			return SelectorTypes.SAC_CONDITIONAL_SELECTOR;
		}
	}
}