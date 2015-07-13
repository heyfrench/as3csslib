package com.newgonzo.web.css.values
{
	import org.w3c.dom.css.CSSPrimitiveValueTypes;
	import org.w3c.dom.css.ICSSPrimitiveValue;
	import org.w3c.dom.css.IRGBColor;

	public class RGBColorValue extends AbstractColorValue implements IRGBColor, IColorValue
	{
		protected var redValue:ICSSPrimitiveValue;
		protected var greenValue:ICSSPrimitiveValue;
		protected var blueValue:ICSSPrimitiveValue;
		protected var alphaValue:ICSSPrimitiveValue;
		
		public function RGBColorValue(primitiveType:int, red:ICSSPrimitiveValue, green:ICSSPrimitiveValue, blue:ICSSPrimitiveValue, alpha:ICSSPrimitiveValue = null)
		{
			redValue = red;
			greenValue = green;
			blueValue = blue;
			alphaValue = alpha;
			
			super(primitiveType);
		}
		
		public function get red():ICSSPrimitiveValue
		{
			return redValue;
		}
		
		public function get green():ICSSPrimitiveValue
		{
			return greenValue;
		}
		
		public function get blue():ICSSPrimitiveValue
		{
			return blueValue;
		}
		
		public function get alpha():ICSSPrimitiveValue
		{
			return alphaValue;
		}
		
		override public function toCSSString():String
		{
			switch(primitiveType)
			{
				case CSSPrimitiveValueTypes.CSS_RGBACOLOR:
					return "rgba(" + redValue.cssText + ", " + greenValue.cssText + ", " + blueValue.cssText + ", " + alphaValue.cssText + ")";
				case CSSPrimitiveValueTypes.CSS_RGBCOLOR:
					return "rgb(" + redValue.cssText + ", " + greenValue.cssText + ", " + blueValue.cssText + ")";
			}
			
			return "";
		}
		
		override protected function calculateValues():void
		{
			opacityValue = calculateOpacityValue(alphaValue);
			
			var r:int = calculateComponentColorValue(redValue);
			var g:int = calculateComponentColorValue(greenValue);
			var b:int = calculateComponentColorValue(blueValue);
			var a:int = calculateAlphaValue(alphaValue);
			
			rgbIntValue = calculateColorValue(r, g, b);
			argbUintValue = calculateColorValue(r, g, b, a);
		}
	}
}