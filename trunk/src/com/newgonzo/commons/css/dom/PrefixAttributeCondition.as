package com.newgonzo.commons.css.dom
{
	import com.newgonzo.commons.css.sac.IAttributeCondition;
	import com.newgonzo.commons.css.sac.ConditionTypes;
	
	public class PrefixAttributeCondition extends AbstractAttributeCondition implements IExtendedCondition, IAttributeCondition
	{	
		public function PrefixAttributeCondition(localName:String, namespaceURI:String, specified:Boolean, value:String)
		{
			super(localName, namespaceURI, specified, value);
		}
		
		public function match(xml:XML):Boolean
		{			
			return attributeIgnoreCase(xml, localName).substr(0, value.length) == value;
		}
		
		public function get conditionType():int
		{
			return ConditionTypes.SAC_PREFIXMATCH_CONDITION;
		}
	}
}