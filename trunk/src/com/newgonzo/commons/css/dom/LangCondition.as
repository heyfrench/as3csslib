package com.newgonzo.commons.css.dom
{
	import com.newgonzo.commons.css.sac.ILangCondition;
	import com.newgonzo.commons.css.sac.ConditionTypes;
	
	public class LangCondition implements IExtendedCondition, ILangCondition
	{
		private var language:String;
		
		public function LangCondition(lang:String)
		{
			language = lang;
		}
		
		public function get lang():String
		{
			return language;
		}
		
		public function match(xml:XML):Boolean
		{
			return xml.hasOwnProperty("@lang") && xml.@lang == language;
		}
		
		public function get conditionType():int
		{
			return ConditionTypes.SAC_LANG_CONDITION;
		}
	}
}