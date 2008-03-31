package com.newgonzo.commons.css.dom
{
	import com.newgonzo.commons.css.sac.IAttributeCondition;
	import com.newgonzo.commons.css.sac.ConditionTypes;
	
	public class ClassCondition extends AbstractAttributeCondition implements IExtendedCondition, IAttributeCondition
	{		
		public function ClassCondition(namespaceURI:String, value:String)
		{
			super(null, namespaceURI, false, value);
		}

		public function match(xml:XML):Boolean
		{
			return attributeIgnoreCase(xml, "class").split(/\s+/g).indexOf(value) != -1;
		}
		
		public function get conditionType():int
		{
			return ConditionTypes.SAC_CLASS_CONDITION;
		}
	}
}