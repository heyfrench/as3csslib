package com.newgonzo.web.css.parser
{
	import org.w3c.css.sac.ILexicalUnit;		

	public class CSSFunctionLexicalUnit extends CSSLexicalUnit
	{
		private var funcName:String;
		private var funcParams:ILexicalUnit;
		
		public function CSSFunctionLexicalUnit(type:uint, functionName:String, functionParams:ILexicalUnit = null, previousLexicalUnit:ILexicalUnit = null)
		{
			super(type, previousLexicalUnit);
		
			funcName = functionName;
			funcParams = functionParams;
		}
		
		override public function get functionName():String
		{
			return funcName;
		}
		
		override public function get parameters():ILexicalUnit
		{
			return funcParams;
		}
	}
}