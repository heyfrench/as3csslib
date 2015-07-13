package com.newgonzo.web.css.values
{
	import org.w3c.dom.css.ICSSValue;
	
	public class PairValue extends AbstractValue
	{
		protected var firstValue:ICSSValue;
		protected var secondValue:ICSSValue;
		
		public function PairValue(first:ICSSValue, second:ICSSValue)
		{
			if(!first || !second)
			{
				throw new ArgumentError("First and second arguments can't be null.");
			}
			
			firstValue = first;
			secondValue = second;
		}
		
		public function get first():ICSSValue
		{
			return firstValue;
		}
		
		public function get second():ICSSValue
		{
			return secondValue;
		}
		
		override public function toCSSString():String
		{
			return firstValue.cssText + " " + secondValue.cssText;
		}
	}
}