package com.newgonzo.commons.css.dom
{
	import com.newgonzo.commons.css.sac.ConditionTypes;
	
	public class OnlyChildCondition implements IExtendedCondition
	{		
		public function OnlyChildCondition()
		{
		}

		public function match(xml:XML):Boolean
		{
			return xml.parent() && xml.parent().children().length() == 1;
		}
		
		public function get conditionType():int
		{
			return ConditionTypes.SAC_ONLY_CHILD_CONDITION;
		}
	}
}