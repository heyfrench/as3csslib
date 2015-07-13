package com.newgonzo.web.css.selectors
{

	
	import org.w3c.css.sac.ICondition;	

	public class AbstractCombinatorCondition
	{
		protected var condition1:IExtendedCondition;
		protected var condition2:IExtendedCondition;
		
		public function AbstractCombinatorCondition(firstCondition:ICondition, secondCondition:ICondition)
		{
			condition1 = firstCondition as IExtendedCondition;
			condition2 = secondCondition as IExtendedCondition;
		}
		
		public function get firstCondition():ICondition
		{
			return condition1;
		}
		
		public function get secondCondition():ICondition
		{
			return condition2;
		}
		
		public function get specificity():uint
		{
			return condition1.specificity + condition2.specificity;
		}
	}
}