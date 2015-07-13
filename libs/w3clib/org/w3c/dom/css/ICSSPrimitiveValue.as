package org.w3c.dom.css
{
		
	public interface ICSSPrimitiveValue extends ICSSValue
	{	
		function get primitiveType():int
		function get stringValue():String
		function get floatValue():Number
		function get rgbColorValue():IRGBColor
		function get rectValue():IRect
		function get counterValue():ICounter
	}
}
