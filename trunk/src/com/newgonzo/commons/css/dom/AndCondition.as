package com.newgonzo.commons.css.dom
{
	import com.newgonzo.commons.css.sac.ICondition;
	import com.newgonzo.commons.css.sac.ICombinatorCondition;
	import com.newgonzo.commons.css.sac.ConditionTypes;
	
	public class AndCondition implements IExtendedCondition, ICombinatorCondition
	{
		private var condition1:IExtendedCondition;
		private var condition2:IExtendedCondition;
		
		public function AndCondition(firstCondition:ICondition, secondCondition:ICondition)
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
		
		public function match(xml:XML):Boolean
		{
			return condition1.match(xml) && condition2.match(xml);
		}
		
		public function get conditionType():int
		{
			return ConditionTypes.SAC_AND_CONDITION;
		}
	}
}