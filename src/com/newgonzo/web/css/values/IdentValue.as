package com.newgonzo.web.css.values
{
	import org.w3c.dom.css.CSSPrimitiveValueTypes;
	
	public class IdentValue extends StringValue
	{
		public function IdentValue(stringValue:String="")
		{
			super(CSSPrimitiveValueTypes.CSS_IDENT, stringValue);
		}
		
		override public function toCSSString():String
		{
			return stringValue;
		}
	}
}