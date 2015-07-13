package com.newgonzo.web.css.values
{
	import org.w3c.dom.css.CSSPrimitiveValueTypes;
	import org.w3c.dom.css.ICSSPrimitiveValue;
	
	public class AbstractColorValue extends AbstractValue
	{
		protected var rgbIntValue:int = 0;
		protected var argbUintValue:uint = 0;
		protected var opacityValue:Number = 1;
		
		public function AbstractColorValue(primitiveType:int)
		{
			super(primitiveType);
			
			calculateValues();
		}
		
		public function get rgb():int
		{
			return rgbIntValue;
		}
		
		public function get argb():uint
		{
			return argbUintValue;
		}
		
		public function get opacity():Number
		{
			return opacityValue;
		}
		
		override public function get floatValue():Number
		{
			return argb;
		}
		
		protected function calculateValues():void
		{
			
		}
		
		protected function calculateColorValue(r:int, g:int, b:int, a:int = -1):uint
		{
			if(a > 0)
			{
				return (a << 24) | (r << 16) | (g << 8) | b;
			}
			else
			{
				return (r << 16) | (g << 8) | b;
			}
		}
		
		protected function calculateComponentColorValue(component:ICSSPrimitiveValue):uint
		{
			if(component.primitiveType == CSSPrimitiveValueTypes.CSS_PERCENTAGE)
			{
				return uint(Math.round(0xFF * (component.floatValue / 100)));
			}
			
			return uint(component.floatValue);
		}
		
		protected function calculateAlphaValue(component:ICSSPrimitiveValue):int
		{
			return int(Math.round(0xFF * calculateOpacityValue(component)));
		}
		
		protected function calculateOpacityValue(component:ICSSPrimitiveValue):Number
		{
			if(!component) return 1;
			
			if(component.primitiveType == CSSPrimitiveValueTypes.CSS_PERCENTAGE)
			{
				return component.floatValue / 100;
			}
			
			return component.floatValue;
		}
	}
}