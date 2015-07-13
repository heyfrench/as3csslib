package com.newgonzo.web.css.values
{
	import org.w3c.dom.css.CSSPrimitiveValueTypes;
	
	public class URIValue extends StringValue
	{
		public function URIValue(uriValue:String = "")
		{
			super(CSSPrimitiveValueTypes.CSS_URI, uriValue);
		}
		
		override public function toCSSString():String
		{
			return "url(" + stringValue + ")";
		}
	}
}