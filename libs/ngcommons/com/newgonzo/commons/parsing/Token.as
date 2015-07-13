package com.newgonzo.commons.parsing
{
	
	public class Token
	{
		public static const UNKNOWN:int = -1;
		public static const EOF:int = 0;
		
		private var tokenType:int;
		private var tokenSource:String;
		private var tokenValue:String;
		private var tokenSourceLine:int;
		private var tokenSourceColumn:int;
		private var previousToken:Token;
		
		public function Token(type:int, source:String = "", value:String = "", line:int = -1, column:int = -1, prevToken:Token = null)
		{
			tokenType = type;
			tokenSource = source;
			tokenValue = value;
			tokenSourceLine = line;
			tokenSourceColumn = column;
			previousToken = prevToken;
		}
		
		public function get type():int
		{
			return tokenType;
		}
		
		public function get value():String
		{
			return tokenValue;
		}
		
		public function get source():String
		{
			return tokenSource;
		}
		
		public function get line():int
		{
			return tokenSourceLine;
		}
		
		public function get column():int
		{
			return tokenSourceColumn;
		}
		
		public function get previous():Token
		{
			return previousToken;
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
			return "[Token(type=" + getTypeName(tokenType) + " source=" + tokenSource + " value='" + tokenValue + "' line=" + tokenSourceLine + " column=" + tokenSourceColumn + ")]";
		}
	}
}