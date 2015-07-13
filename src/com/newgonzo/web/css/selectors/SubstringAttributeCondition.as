package com.newgonzo.web.css.selectors
{
	import com.newgonzo.web.css.ICSSDocument;
	
	import org.w3c.css.sac.ConditionTypes;
	import org.w3c.css.sac.IAttributeCondition;	

	public class SubstringAttributeCondition extends AbstractAttributeCondition implements IExtendedCondition, IAttributeCondition
	{		
		public function SubstringAttributeCondition(localName:String, namespaceURI:String, specified:Boolean, value:String)
		{
			super(localName, namespaceURI, specified, value);
		}
		
		override protected function matchValue(attribute:String):Boolean
		{	
			return attribute.indexOf(value) != -1;
		}
		
		public function get conditionType():int
		{
			return ConditionTypes.SAC_SUBSTRINGMATCH_CONDITION;
		}
		
		public function toCSSString(document:ICSSDocument):String
		{
			return formatToString(document, "*=");
		}
	}
}