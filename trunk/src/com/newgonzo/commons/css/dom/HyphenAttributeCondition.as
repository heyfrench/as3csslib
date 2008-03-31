package com.newgonzo.commons.css.dom
{
	import com.newgonzo.commons.css.sac.IAttributeCondition;
	import com.newgonzo.commons.css.sac.ConditionTypes;
	
	public class HyphenAttributeCondition extends AbstractAttributeCondition implements IExtendedCondition, IAttributeCondition
	{		
		public function HyphenAttributeCondition(localName:String, namespaceURI:String, specified:Boolean, value:String)
		{
			super(localName, namespaceURI, specified, value);
		}

		public function match(xml:XML):Boolean
		{			
			var test:Array = attributeIgnoreCase(xml, localName).split(/-/g);
			return test[0] == value;
		}
		
		public function get conditionType():int
		{
			return ConditionTypes.SAC_ONE_OF_ATTRIBUTE_CONDITION;
		}
	}
}