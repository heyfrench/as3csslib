package com.newgonzo.commons.parsing
{
	public class ParseError extends Error
	{
		private var sourceColumn:int;
		private var sourceLine:int;
		
		public function ParseError(message:String, id:int = 0, column:int = 0, line:int = 0)
		{
			super(message, id);
			
			sourceColumn = column;
			sourceLine = line;
		}
		
		public function toString():String
		{
			return "ParseError: " + message + " at column " + sourceColumn + " line " + sourceLine;
		}
	}
}