package com.newgonzo.commons.parsing
{
	
	public class Token
	{
		public static const EOF:int = -1;
		
		private var tokenType:int;
		private var tokenValue:String;
		private var tokenSourceIndex:int;
		private var tokenSourceColumn:int;
		private var tokenSourceRow:int;
		
		public function Token(type:int, value:String = "", sourceIndex:int = -1, sourceColumn:int = 1, sourceRow:int = 1)
		{
			tokenType = type;
			tokenValue = value;
			tokenSourceIndex = sourceIndex;
			tokenSourceColumn = sourceColumn;
			tokenSourceRow = sourceRow;
		
		}
		
		public function get type():int
		{
			return tokenType;
		}
		
		public function get value():String
		{
			return tokenValue;
		}
		
		public function get sourceIndex():int
		{
			return tokenSourceIndex;
		}
		
		public function get column():int
		{
			return tokenSourceColumn;
		}
		
		public function get row():int
		{
			return tokenSourceRow;
		}
		
		
		/**
		* Override in subclasses to provide meaningful names for token types
		*/
		public function getTypeName(type:int):String
		{
			switch(type)
			{
				case EOF: return "EOF";
				default: return tokenType.toString();
			}
		}
		
		public function toString():String
		{
			return "[Token(type=" + getTypeName(tokenType) + " value='" + tokenValue + "' index=" + tokenSourceIndex + " column=" + tokenSourceColumn + " row=" + tokenSourceRow + ")]";
		}
	}
}