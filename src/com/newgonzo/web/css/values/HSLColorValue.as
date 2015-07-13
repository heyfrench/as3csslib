package com.newgonzo.web.css.values
{
	import org.w3c.dom.css.CSSPrimitiveValueTypes;
	import org.w3c.dom.css.ICSSPrimitiveValue;

	public class HSLColorValue extends AbstractColorValue implements IColorValue
	{
		protected var hueValue:ICSSPrimitiveValue;
		protected var saturationValue:ICSSPrimitiveValue;
		protected var lightnessValue:ICSSPrimitiveValue;
		protected var alphaValue:ICSSPrimitiveValue;
		
		public function HSLColorValue(primitiveType:int, hue:ICSSPrimitiveValue, saturation:ICSSPrimitiveValue, lightness:ICSSPrimitiveValue, alpha:ICSSPrimitiveValue=null)
		{
			hueValue = hue;
			saturationValue = saturation;
			lightnessValue = lightness;
			alphaValue = alpha;
			
			super(primitiveType);
		}
		
		public function get hue():ICSSPrimitiveValue
		{
			return hueValue;
		}
		
		public function get saturation():ICSSPrimitiveValue
		{
			return saturationValue;
		}
		
		public function get lightness():ICSSPrimitiveValue
		{
			return lightnessValue;
		}
		
		public function get alpha():ICSSPrimitiveValue
		{
			return alphaValue;
		}
		
		override public function toCSSString():String
		{
			switch(primitiveType)
			{
				case CSSPrimitiveValueTypes.CSS_HSLACOLOR:
					return "hsla(" + hueValue.cssText + ", " + saturationValue.cssText + ", " + lightnessValue.cssText + ", " + alphaValue.cssText + ")";
				case CSSPrimitiveValueTypes.CSS_HSLCOLOR:
					return "hsl(" + hueValue.cssText + ", " + saturationValue.cssText + ", " + lightnessValue.cssText + ")";
			}
			
			return "";
		}
		
		override protected function calculateValues():void
		{
			opacityValue = calculateOpacityValue(alphaValue);
			
			var h:Number = hueValue.floatValue / 360;
			var s:Number = saturationValue.floatValue / 100;
			var l:Number = lightnessValue.floatValue / 100;
			
			var r:int;
			var g:int;
			var b:int;
			var a:int = calculateAlphaValue(alphaValue);
			
			var temp1:Number;
			var temp2:Number;
			
			if(s == 0)
			{
				r = l * 0xFF;
				g = l * 0xFF;
				b = l * 0xFF;
			}
			else
			{
				if(l < .5)
				{
					temp2 = l * (1 + s);
				}
				else
				{
					temp2 = (l + s) - (s * l);
				}
				
				temp1 = 2 * l - temp2;
				
				r = int(Math.round(0xFF * hueToRgb(temp1, temp2, h + (1 / 3))));
				g = int(Math.round(0xFF * hueToRgb(temp1, temp2, h)));
				b = int(Math.round(0xFF * hueToRgb(temp1, temp2, h - (1 / 3))));
			}
			
			//trace("r: " + r + " g: " + g + " b: " + b + " a: " + a);
			
			rgbIntValue = calculateColorValue(r, g, b);
			argbUintValue = calculateColorValue(r, g, b, a);
		}
		
		protected function hueToRgb(m1:Number, m2:Number, hue:Number):Number
		{
			var v:Number;
			
			if(hue < 0)
			{
				hue += 1;
			}
			if(hue > 1)
			{
				hue -= 1;
			}
			
			if(6 * hue < 1)
			{
				return (m1 + (m2 - m1) * 6 * hue);
			}
			
			if(2 * hue < 1)
			{
				return m2;
			}
			
			if(3 * hue < 2)
			{
				return (m1 + (m2 - m1) * ((2 / 3) - hue) * 6);
			}
			
			return m1;
		}
	}
}