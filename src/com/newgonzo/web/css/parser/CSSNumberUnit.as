package com.newgonzo.web.css.parser
{
	import org.w3c.css.sac.ILexicalUnit;
	
	public class CSSNumberUnit extends CSSLexicalUnit
	{
		private var value:Number;
		
		public function CSSNumberUnit(type:uint, unitValue:Number, previousLexicalUnit:ILexicalUnit = null, parentLexicalUnit:ILexicalUnit = null)
		{
			super(type, previousLexicalUnit, parentLexicalUnit);
			
			value = unitValue;
		}
		
		override public function get stringValue():String
		{
			return String(value);
		}
		
		override public function get floatValue():Number
		{
			return value;
		}
		
		override public function get integerValue():int
		{
			return int(value);
		}
	}
}