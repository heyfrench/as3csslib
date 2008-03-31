package com.newgonzo.commons.css.parser
{
	import com.newgonzo.commons.parsing.Token;
	
	public class CSSToken extends Token
	{
		/**
		* Represents the '=' lexical unit.
		*/
		public static const EQUAL:int = 1;
		
		/**
		* Represents the '+' lexical unit.
		*/
		public static const PLUS:int = 2;
		
		/**
		* Represents the '-' lexical unit.
		*/
		public static const MINUS:int = 3;
		
		/**
		* Represents the '~' lexical unit.
		*/
		public static const TILDE:int = 4;
		
		/**
		* Represents the ',' lexical unit.
		*/
		public static const COMMA:int = 5;
		
		/**
		* Represents the '.' lexical unit.
		*/
		public static const DOT:int = 6;
		
		/**
		* Represents the ';' lexical unit.
		*/
		public static const SEMI_COLON:int = 7;
		
		/**
		* Represents the '&gt;' lexical unit.
		*/
		public static const PRECEDE:int = 8;
		
		/**
		* Represents the '/' lexical unit.
		*/
		public static const DIVIDE:int = 9;
		
		/**
		* Represents the '[' lexical unit.
		*/
		public static const LEFT_BRACKET:int = 10;
		
		/**
		* Represents the ']' lexical unit.
		*/
		public static const RIGHT_BRACKET:int = 11;
		
		/**
		* Represents the '*' lexical unit.
		*/
		public static const ANY:int = 12;
		
		/**
		* Represents the '(' lexical unit.
		*/
		public static const LEFT_BRACE:int = 13;
		
		/**
		* Represents the ')' lexical unit.
		*/
		public static const RIGHT_BRACE:int = 14;
		
		/**
		* Represents the ':' lexical unit.
		*/
		public static const COLON:int = 15;
		
		/**
		* Represents the white space lexical unit.
		*/
		public static const SPACE:int = 16;
		
		/**
		* Represents the comment lexical unit.
		*/
		public static const COMMENT:int = 17;
		
		/**
		* Represents the string lexical unit.
		*/
		public static const STRING:int = 18;
		
		/**
		* Represents the identifier lexical unit.
		*/
		public static const IDENTIFIER:int = 19;
		
		/**
		* Represents the '|=' lexical unit.
		*/
		public static const DASHMATCH:int = 20;
		
		/**
		* Represents the '~=' lexical unit.
		*/
		public static const INCLUDES:int = 21;
		
		/**
		* Represents the '^=' lexical unit.
		*/
		public static const PREFIXMATCH:int = 22;
		
		/**
		* Represents the '$=' lexical unit.
		*/
		public static const SUFFIXMATCH:int = 23;
		
		/**
		* Represents the '*=' lexical unit.
		*/
		public static const SUBSTRINGMATCH:int = 24;
		
		/**
		* Represents the '#name' lexical unit.
		*/
		public static const HASH:int = 25;
		
		/**
		* Represents a 'ident(' lexical unit.
		*/
		public static const FUNCTION:int = 26;
		
		/**
		* Represents a ':not(' lexical unit.
		*/
		public static const NOT:int = 27;
		
		/**
		* Represents a number lexical unit.
		*/
		public static const NUMBER:int = 28;
		
		/**
		* Represents a vertical bar (|) lexical unit
		*/
		public static const VERTICAL_BAR:int = 29;
		
		public static const LEFT_CURLY_BRACE:int = 30;
		public static const RIGHT_CURLY_BRACE:int = 31;
		
		public static const HEXADECIMAL:int = 32;
		public static const PERCENT:int = 33;
		
		public function CSSToken(type:int, value:String, sourceIndex:int)
		{
			super(type, value, sourceIndex);
		}
		
		override public function getTypeName(type:int):String
		{
			switch(type)
			{
				case EQUAL: return "EQUAL";
				case PLUS: return "PLUS";
				case MINUS: return "MINUS";
				case TILDE: return "TILDE";
				case COMMA: return "COMMA";
				case DOT: return "DOT";
				case SEMI_COLON: return "SEMI_COLON";
				case PRECEDE: return "PRECEDE";
				case DIVIDE: return "DIVIDE";
				case LEFT_BRACKET: return "LEFT_BRACKET";
				case RIGHT_BRACKET: return "RIGHT_BRACKET";
				case ANY: return "ANY";
				case LEFT_BRACE: return "LEFT_BRACE";
				case RIGHT_BRACE: return "RIGHT_BRACE";
				case COLON: return "COLON";
				case SPACE: return "SPACE";
				case COMMENT: return "COMMENT";
				case STRING: return "STRING";
				case IDENTIFIER: return "IDENTIFIER";
				case DASHMATCH: return "DASHMATCH";
				case INCLUDES: return "INCLUDES";
				case PREFIXMATCH: return "PREFIXMATCH";
				case SUFFIXMATCH: return "SUFFIXMATCH";
				case SUBSTRINGMATCH: return "SUBSTRINGMATCH";
				case HASH: return "HASH";
				case FUNCTION: return "FUNCTION";
				case NOT: return "NOT";
				case NUMBER: return "NUMBER";
				case VERTICAL_BAR: return "VERTICAL_BAR";
				case HEXADECIMAL: return "HEXADECIMAL";
				case RIGHT_CURLY_BRACE: return "RIGHT_CURLY_BRACE";
				case LEFT_CURLY_BRACE: return "LEFT_CURLY_BRACE";
				case PERCENT: return "PERCENT";
			
				default: return super.getTypeName(type);
			}
			
			
		}
	}
}