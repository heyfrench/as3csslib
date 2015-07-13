package com.newgonzo.web.css.parser
{
	import org.w3c.css.sac.ILexicalUnit;
	

	public class CSSDimensionUnit extends CSSNumberUnit
	{
		private var dimensionalText:String;
		
		public function CSSDimensionUnit(type:uint, value:Number = 0, previousLexicalUnit:ILexicalUnit = null)
		{
			// previous lexical unit here is the value for this dimension
			super(type, value, previousLexicalUnit);
		}
		
		override public function get dimensionalUnitText():String
		{
			return nextLexicalUnit ? nextLexicalUnit.stringValue : null;
		}
	}
}