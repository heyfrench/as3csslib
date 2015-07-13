package com.newgonzo.web.css.selectors
{
	import com.newgonzo.web.css.ICSSDocument;
	
	import org.w3c.css.sac.ConditionTypes;
	import org.w3c.css.sac.IAttributeCondition;	

	public class HyphenAttributeCondition extends AbstractAttributeCondition implements IExtendedCondition, IAttributeCondition
	{		
		public function HyphenAttributeCondition(localName:String, namespaceURI:String, specified:Boolean, value:String)
		{
			super(localName, namespaceURI, specified, value);
		}

		override protected function matchValue(attribute:String):Boolean
		{
			// From http://www.w3.org/TR/css3-selectors/#attribute-selectors
			// [att|=val]
    		// Represents an element with the att attribute, its value either being exactly "val" or beginning with "val" immediately followed by "-" (U+002D).
			return attribute.substr(0, value.length + 1) == value + "-"
		}
		
		public function get conditionType():int
		{
			return ConditionTypes.SAC_ONE_OF_ATTRIBUTE_CONDITION;
		}
		
		public function toCSSString(document:ICSSDocument):String
		{
			return formatToString(document, "|=");
		}
	}
}