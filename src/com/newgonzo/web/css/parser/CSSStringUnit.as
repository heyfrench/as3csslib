package com.newgonzo.web.css.parser
{
	import org.w3c.css.sac.ILexicalUnit;
	

	public class CSSStringUnit extends CSSLexicalUnit
	{
		private var text:String;
		
		public function CSSStringUnit(type:uint, unitText:String, previousLexicalUnit:ILexicalUnit = null)
		{
			super(type, previousLexicalUnit);
			
			text = unitText;
		}
		
		override public function get stringValue():String
		{
			return text;
		}
	}
}