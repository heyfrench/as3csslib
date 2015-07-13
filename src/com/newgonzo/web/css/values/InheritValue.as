package com.newgonzo.web.css.values
{
	import flash.errors.IllegalOperationError;
	
	import org.w3c.dom.css.CSSValueTypes;

	public class InheritValue extends AbstractValue
	{
		public static const INHERIT:String = "inherit";
		
		public function InheritValue()
		{
		}
		
		override public function get cssValueType():int
		{
			return CSSValueTypes.CSS_INHERIT;
		}
		
		override public function get primitiveType():int
		{
			throw new IllegalOperationError("InheritValue has no primitive type.");
		}
		
		override public function toCSSString():String
		{
			return INHERIT;
		}
	}
}