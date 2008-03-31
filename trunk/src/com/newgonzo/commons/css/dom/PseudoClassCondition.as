package com.newgonzo.commons.css.dom
{
	import com.newgonzo.commons.css.sac.IAttributeCondition;
	import com.newgonzo.commons.css.sac.ConditionTypes;
	
	public class PseudoClassCondition extends AbstractAttributeCondition implements IExtendedCondition, IAttributeCondition
	{		
		public function PseudoClassCondition(namespaceURI:String, value:String)
		{
			super(null, namespaceURI, false, value);
		}

		public function match(xml:XML):Boolean
		{
			switch(value)
			{
				case "root":
				
					return xml.parent() == null;
					
				case "empty":
					return xml.children().length() == 0;
			
				default:
					throw new Error("Unsupported pseudo-class " + value);
			}
			
			return false;
		}
		
		public function get conditionType():int
		{
			return ConditionTypes.SAC_PSEUDO_CLASS_CONDITION;
		}
	}
}