package com.newgonzo.web.css.values
{
	import org.w3c.dom.css.CSSPrimitiveValueTypes;
	import org.w3c.dom.css.ICSSPrimitiveValue;
	import org.w3c.dom.css.IRect;
	
	public class RectValue extends AbstractValue implements IRect
	{
		protected var topValue:ICSSPrimitiveValue;
		protected var rightValue:ICSSPrimitiveValue;
		protected var bottomValue:ICSSPrimitiveValue;
		protected var leftValue:ICSSPrimitiveValue;
		
		public function RectValue(top:ICSSPrimitiveValue, right:ICSSPrimitiveValue, bottom:ICSSPrimitiveValue, left:ICSSPrimitiveValue)
		{
			super(CSSPrimitiveValueTypes.CSS_RECT);
			
			topValue = top;
			rightValue = right;
			bottomValue = bottom;
			leftValue = left;
		}
		
		public function get top():ICSSPrimitiveValue
		{
			return topValue;
		}
		
		public function get right():ICSSPrimitiveValue
		{
			return rightValue;
		}
		
		public function get bottom():ICSSPrimitiveValue
		{
			return bottomValue;
		}
		
		public function get left():ICSSPrimitiveValue
		{
			return leftValue;
		}
		
		override public function toCSSString():String
		{
			return "rect(" + topValue.cssText + ", " + rightValue.cssText + ", " + bottomValue.cssText + ", " + leftValue.cssText + ")";
		}
	}
}