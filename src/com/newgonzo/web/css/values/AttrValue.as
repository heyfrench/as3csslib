package com.newgonzo.web.css.values
{
	import org.w3c.dom.css.CSSPrimitiveValueTypes;
	
	public class AttrValue extends FunctionValue
	{
		public static const ATTR:String = "attr";
		
		public function AttrValue(attributeName:String)
		{
			super(CSSPrimitiveValueTypes.CSS_ATTR, ATTR, [attributeName]);
		}
	}
}