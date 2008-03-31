package com.newgonzo.commons.css.dom
{
	import com.newgonzo.commons.css.sac.IAttributeCondition;
	import com.newgonzo.commons.css.sac.ConditionTypes;
	
	public class SuffixAttributeCondition extends AbstractAttributeCondition implements IExtendedCondition, IAttributeCondition
	{		
		public function SuffixAttributeCondition(localName:String, namespaceURI:String, specified:Boolean, value:String)
		{
			super(localName, namespaceURI, specified, value);
		}
		
		public function match(xml:XML):Boolean
		{
			return attributeIgnoreCase(xml, localName).substr(-value.length) == value;
		}
		
		public function get conditionType():int
		{
			return ConditionTypes.SAC_SUFFIXMATCH_CONDITION;
		}
	}
}