package com.newgonzo.web.css.values
{
	import org.w3c.dom.css.CSSPrimitiveValueTypes;
	
	public class FloatValue extends AbstractValue
	{
		protected static const UNITS:Array = ["", "%", "em", "ex", "px", "cm", "mm", "in", "pt", "pc", "deg", "rad", "grad", "ms", "s", "Hz", "kHz", ""];
		
		protected var float:Number;
		
		public function FloatValue(primitiveType:uint, floatValue:Number = 0)
		{
			super(primitiveType);
			float = floatValue;
		}
		
		override public function get floatValue():Number
		{
			return float;
		}
		
		override public function toCSSString():String
		{
			return float.toString() + UNITS[primitiveType - CSSPrimitiveValueTypes.CSS_NUMBER];
		}
	}
}