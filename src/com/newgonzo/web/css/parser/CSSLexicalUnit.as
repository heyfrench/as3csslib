package com.newgonzo.web.css.parser
{
	import org.w3c.css.sac.ILexicalUnit;		

	public class CSSLexicalUnit implements ILexicalUnit
	{
		private var unitType:uint;
		private var subUnit:ILexicalUnit;
		
		private var nextUnit:ILexicalUnit;
		private var prevUnit:ILexicalUnit;
		
		public function CSSLexicalUnit(type:uint, previousLexicalUnit:ILexicalUnit = null, parentUnit:ILexicalUnit = null)
		{
			unitType = type;
			prevUnit = previousLexicalUnit;
			
			if(parentUnit is CSSLexicalUnit)
			{
				(parentUnit as CSSLexicalUnit).subUnit = this;
			}
			
			if(prevUnit is CSSLexicalUnit)
			{
				(prevUnit as CSSLexicalUnit).nextUnit = this;
			}
		}
		
		public function get type():uint
		{
			return unitType;
		}
		
		public function get nextLexicalUnit():ILexicalUnit
		{
			return nextUnit;
		}
		
		public function get previousLexicalUnit():ILexicalUnit
		{
			return prevUnit;
		}
		
		public function get subValues():ILexicalUnit
		{
			return subUnit;
		}
		
		public function get dimensionalUnitText():String
		{
			return subUnit ? subUnit.dimensionalUnitText : "";
		}
		
		public function get functionName():String
		{
			return null;
		}
		
		public function get parameters():ILexicalUnit
		{
			return null;
		}
		
		public function get stringValue():String
		{
			return null;
		}

		public function get floatValue():Number
		{
			return NaN;
		}
		
		public function get integerValue():int
		{
			return -1;
		}
		
		public function toString():String
		{
			return "[CSSLexicalUnit(type=" + type + ", stringValue=" + stringValue + ", nextLexicalUnit=" + nextLexicalUnit + ")]";
		}
	}
}