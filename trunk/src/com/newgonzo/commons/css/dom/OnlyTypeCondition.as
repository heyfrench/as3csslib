package com.newgonzo.commons.css.dom
{
	import com.newgonzo.commons.css.sac.ConditionTypes;
	
	public class OnlyTypeCondition implements IExtendedCondition
	{		
		public function OnlyTypeCondition()
		{
		}

		public function match(xml:XML):Boolean
		{
			var parent:XML = xml.parent();
			
			if(!parent || !xml.localName())
			{
				return false;
			}
			
			var type:String = xml.localName().toString();
			return parent.children().(localName() && localName().toString().toLowerCase() == type.toLowerCase()).length() == 1;
		}
		
		public function get conditionType():int
		{
			return ConditionTypes.SAC_ONLY_TYPE_CONDITION;
		}
	}
}