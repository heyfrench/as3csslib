package com.newgonzo.web.css.values
{
	import com.newgonzo.web.css.ICSSDocument;
	
	import flash.errors.IllegalOperationError;
	
	import org.w3c.css.sac.CSSError;
	import org.w3c.dom.css.CSSValueTypes;
	import org.w3c.dom.css.ICSSValue;
	import org.w3c.dom.css.ICounter;
	import org.w3c.dom.css.IRGBColor;
	import org.w3c.dom.css.IRect;	

	public class AbstractValue implements IValue
	{
		protected var cssDocument:ICSSDocument;
		protected var css:String;
		
		private var primitiveValueType:uint;
		
		private var strValue:String;
		private var numValue:Number;
		
		public function AbstractValue(primitiveType:int = -1)
		{
			if(primitiveType > 0)
			{
				primitiveValueType = primitiveType;
			}
		}
		
		public function get cssValueType():int
		{
			return CSSValueTypes.CSS_PRIMITIVE_VALUE;
		}
		
		public function get primitiveType():int
		{
			return primitiveValueType;
		}
		
		public function get document():ICSSDocument
		{
			return cssDocument;
		}
		public function set document(value:ICSSDocument):void
		{
			cssDocument = value;
		}
		
		public function get cssText():String
		{
			if(!css)
			{
				css = toCSSString();
			}
			
			return css;
		}
		public function set cssText(value:String):void
		{
			css = value;
		}
		
		public function get stringValue():String
		{
			return strValue;
		}
		public function set stringValue(value:String):void
		{
			strValue = value;
		}
		
		public function get floatValue():Number
		{
			return numValue;
		}

		public function get rgbColorValue():IRGBColor
		{
			return this as IRGBColor;
		}
		
		public function get rectValue():IRect
		{
			return this as IRect;
		}
		
		public function get counterValue():ICounter
		{
			return this as ICounter;
		}
		
		public function get length():int
		{
			throw new IllegalOperationError("Value is not a list.");
		}
		
		public function item(index:int):ICSSValue
		{
			throw new IllegalOperationError("Value is not a list.");
		}
		
		public function toString():String
		{
			return cssText;
		}
		
		public function toCSSString():String
		{
			throw new IllegalOperationError("AbstractValue.toCSSString() must be overridden.");
		}
	}
}
