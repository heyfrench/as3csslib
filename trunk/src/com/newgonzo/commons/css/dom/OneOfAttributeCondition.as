package com.newgonzo.commons.css.dom
{
	import com.newgonzo.commons.css.sac.IAttributeCondition;
	import com.newgonzo.commons.css.sac.ConditionTypes;
	
	public class OneOfAttributeCondition extends AbstractAttributeCondition implements IExtendedCondition, IAttributeCondition
	{		
		public function OneOfAttributeCondition(localName:String, namespaceURI:String, specified:Boolean, value:String)
		{
			super(localName, namespaceURI, specified, value);
		}

		public function match(xml:XML):Boolean
		{			
			return attributeIgnoreCase(xml, localName).split(/\s+/g).indexOf(value) != -1;
		}
		
		public function get conditionType():int
		{
			return ConditionTypes.SAC_ONE_OF_ATTRIBUTE_CONDITION;
		}
	}
}