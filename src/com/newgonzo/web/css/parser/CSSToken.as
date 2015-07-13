package com.newgonzo.web.css.parser
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
		
		/**
		* Represents a % lexical unit.
		*/
		public static const PERCENTAGE:int = 33;
		
		public static const IMPORTANT_SYMBOL:int = 34;
		
		/**
		* Represents a ex lexical unit.
		*/
		public static const EX:int = 35;
		
		/**
		* Represents a em lexical unit.
		*/
		public static const EM:int = 36;
		
		/**
		* Represents a cm lexical unit.
		*/
		public static const CM:int = 37;
		
		/**
		* Represents a mm lexical unit.
		*/
		public static const MM:int = 38;
		
		/**
		* Represents a in lexical unit.
		*/
		public static const IN:int = 39;
		
		/**
		* Represents a ms lexical unit.
		*/
		public static const MS:int = 40;
		
		/**
		* Represents a hz lexical unit.
		*/
		public static const HZ:int = 41;
		
		/**
		* Represents a s lexical unit.
		*/
		public static const S:int = 43;
		
		/**
		* Represents a pc lexical unit.
		*/
		public static const PC:int = 44;
		
		/**
		* Represents a pt lexical unit.
		*/
		public static const PT:int = 45;
		
		/**
		* Represents a px lexical unit.
		*/
		public static const PX:int = 46;
		
		/**
		* Represents a deg lexical unit.
		*/
		public static const DEG:int = 47;
		
		/**
		* Represents a rad lexical unit.
		*/
		public static const RAD:int = 48;
		
		/**
		* Represents a grad lexical unit.
		*/
		public static const GRAD:int = 49;
		
		/**
		* Represents a khz lexical unit.
		*/
		public static const KHZ:int = 50;
		
		/**
		* Represents a 'url(URI)' lexical unit.
		*/
		public static const URI:int = 51;
		
		/**
		* Represents an @rule
		*/
		public static const AT_RULE:int = 52;
		
		/**
		* Represents an SGML open comment delimiter
		*/
		public static const CDO:int = 53;
		
		/**
		* Represents an SGML close comment delimiter
		*/
		public static const CDC:int = 54;
		
		
		public function CSSToken(type:int, source:String = "", value:String = "", line:int = -1, column:int = -1, prevToken:Token = null)
		{
			super(type, source, value, line, column, prevToken);
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
				case PERCENTAGE: return "PERCENTAGE";
				case IMPORTANT_SYMBOL: return "IMPORTANT_SYMBOL";
				case URI: return "URI";
				case AT_RULE: return "AT_RULE";
				case CDO: return "CDO";
				case CDC: return "CDC";
			
				default: return super.getTypeName(type);
			}
			
			
		}
	}
}