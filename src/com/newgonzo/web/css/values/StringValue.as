package com.newgonzo.web.css.values
{
	public class StringValue extends AbstractValue
	{
		protected var strValue:String;
		
		public function StringValue(valueType:int, stringValue:String = "")
		{
			super(valueType);
			strValue = stringValue;
		}
		
		override public function get stringValue():String
		{
			return strValue;
		}
		
		override public function toCSSString():String
		{
			// TODO: Escape?
			return "\"" + strValue + "\"";
		}
	}
}