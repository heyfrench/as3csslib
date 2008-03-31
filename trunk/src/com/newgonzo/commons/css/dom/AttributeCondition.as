package com.newgonzo.commons.css.dom
{
	import com.newgonzo.commons.css.sac.ConditionTypes;
	import com.newgonzo.commons.css.sac.IAttributeCondition;
	
	public class AttributeCondition extends AbstractAttributeCondition implements IExtendedCondition, IAttributeCondition
	{
		public function AttributeCondition(localName:String, namespaceURI:String, specified:Boolean, value:String)
		{
			super(localName, namespaceURI, specified, value);
		}
		
		public function match(xml:XML):Boolean
		{
			var test:String = localName.toLowerCase();
			
			if(value)
			{
				return xml.attributes().(name().toString().toLowerCase() == test).toString() == value;
			}
			else
			{				
				return xml.attributes().(name().toString().toLowerCase() == test).length() > 0;
			}
		}
		
		public function get conditionType():int
		{
			return ConditionTypes.SAC_ATTRIBUTE_CONDITION;
		}
	}
}