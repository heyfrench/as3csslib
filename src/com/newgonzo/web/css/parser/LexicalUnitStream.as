package com.newgonzo.web.css.parser
{
	import org.w3c.css.sac.CSSError;
	import org.w3c.css.sac.ILexicalUnit;
	
	public class LexicalUnitStream
	{
		protected var startUnit:ILexicalUnit;
		protected var currentUnit:ILexicalUnit;
		
		public function LexicalUnitStream(lexicalUnit:ILexicalUnit)
		{
			startUnit = lexicalUnit;
			currentUnit = startUnit;
		}
		
		public function get current():ILexicalUnit
		{
			return currentUnit;
		}
		public function set current(value:ILexicalUnit):void
		{
			currentUnit = value;
		}
		
		public function get hasNext():Boolean
		{
			return currentUnit.nextLexicalUnit != null;
		}

		public function next():ILexicalUnit
		{
			if(currentUnit)
			{
				currentUnit = currentUnit.nextLexicalUnit;
			}

			return currentUnit;
		}
		
		public function previous():ILexicalUnit
		{
			if(currentUnit)
			{
				currentUnit = currentUnit.previousLexicalUnit;
			}
			
			return currentUnit;
		}
		
		public function reset():void
		{
			currentUnit = startUnit;
		}
		
		public function toString():String
		{
			return "[LexicalUnitStream(current=" + currentUnit + ")]";
		}
	}
}