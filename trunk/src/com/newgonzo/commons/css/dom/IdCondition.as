package com.newgonzo.commons.css.dom
{
	import com.newgonzo.commons.css.sac.IAttributeCondition;
	import com.newgonzo.commons.css.sac.ConditionTypes;
	
	public class IdCondition extends AbstractAttributeCondition implements IExtendedCondition, IAttributeCondition
	{		
		public function IdCondition(value:String)
		{
			super(null, null, false, value);
		}

		public function match(xml:XML):Boolean
		{
			return attributeIgnoreCase(xml, "id") == value;
		}
		
		public function get conditionType():int
		{
			return ConditionTypes.SAC_ID_CONDITION;
		}
	}
}