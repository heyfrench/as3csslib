package com.newgonzo.web.css.parser
{
	import com.newgonzo.commons.parsing.Token;
	import com.newgonzo.commons.parsing.TokenPattern;
	import com.newgonzo.commons.parsing.Tokenizer;
	
	import org.w3c.css.sac.CSSError;
	import org.w3c.css.sac.CSSErrorTypes;	

	public class CSSTokenizer extends Tokenizer
	{
		public static var tokenPatternCache:Array = new Array();
		addTokenPatterns();
		
		public function CSSTokenizer(source:String)
		{
			super(source);
		}
		
		override protected function get tokenPatterns():Array
		{
			return tokenPatternCache;
		}
		
		protected static function addTokenPattern(tokenPattern:TokenPattern):void
		{
			tokenPatternCache.push(tokenPattern);
		}
		
		protected static function addTokenPatterns():void
		{
			// order is significant
			
			addTokenPattern(new TokenPattern(CSSToken.SPACE, matchWhitespace));
			
			addTokenPattern(new TokenPattern(CSSToken.LEFT_CURLY_BRACE, "{"));
			addTokenPattern(new TokenPattern(CSSToken.RIGHT_CURLY_BRACE, "}"));
			
			addTokenPattern(new TokenPattern(CSSToken.NOT, ":not("));
			addTokenPattern(new TokenPattern(CSSToken.COLON, ":"));
			
			addTokenPattern(new TokenPattern(CSSToken.SEMI_COLON, ";"));
			addTokenPattern(new TokenPattern(CSSToken.COMMA, ","));
			
			addTokenPattern(new TokenPattern(CSSToken.LEFT_BRACKET, "["));
			addTokenPattern(new TokenPattern(CSSToken.RIGHT_BRACKET, "]"));
			
			addTokenPattern(new TokenPattern(CSSToken.LEFT_BRACE, "("));
			addTokenPattern(new TokenPattern(CSSToken.RIGHT_BRACE, ")"));
			
			addTokenPattern(new TokenPattern(CSSToken.CDO, "<!--"));
			addTokenPattern(new TokenPattern(CSSToken.CDC, "-->"));
			
			addTokenPattern(new TokenPattern(CSSToken.URI, matchURI));
			addTokenPattern(new TokenPattern(CSSToken.FUNCTION, matchFunction));
			
			addTokenPattern(new TokenPattern(CSSToken.IDENTIFIER, matchIdentifier));
			addTokenPattern(new TokenPattern(CSSToken.STRING, matchString));
			
			addTokenPattern(new TokenPattern(CSSToken.NUMBER, matchNumber));
			
			addTokenPattern(new TokenPattern(CSSToken.HASH, matchHash));
			addTokenPattern(new TokenPattern(CSSToken.AT_RULE, matchAtRule));
			addTokenPattern(new TokenPattern(CSSToken.HEXADECIMAL, matchHex));
			addTokenPattern(new TokenPattern(CSSToken.IMPORTANT_SYMBOL, matchImportant));
			
			addTokenPattern(new TokenPattern(CSSToken.COMMENT, matchComment));
			
			addTokenPattern(new TokenPattern(CSSToken.PERCENTAGE, "%"));
			addTokenPattern(new TokenPattern(CSSToken.DASHMATCH, "|="));
			addTokenPattern(new TokenPattern(CSSToken.INCLUDES, "~="));
			addTokenPattern(new TokenPattern(CSSToken.PREFIXMATCH, "^="));
			addTokenPattern(new TokenPattern(CSSToken.SUFFIXMATCH, "$="));
			addTokenPattern(new TokenPattern(CSSToken.SUBSTRINGMATCH, "*="));
			addTokenPattern(new TokenPattern(CSSToken.DOT, "."));
			addTokenPattern(new TokenPattern(CSSToken.PRECEDE, ">"));
			addTokenPattern(new TokenPattern(CSSToken.ANY, "*"));
			addTokenPattern(new TokenPattern(CSSToken.EQUAL, "="));
			addTokenPattern(new TokenPattern(CSSToken.PLUS, "+"));
			addTokenPattern(new TokenPattern(CSSToken.MINUS, "-"));
			addTokenPattern(new TokenPattern(CSSToken.DIVIDE, "/"));
			addTokenPattern(new TokenPattern(CSSToken.TILDE, "~"));
			addTokenPattern(new TokenPattern(CSSToken.VERTICAL_BAR, "|"));
		}
		
		override protected function createToken(type:int, source:String, line:int = -1, column:int = -1, prevToken:Token = null):Token
		{
			var tokenValue:String = source;
			
			switch(type)
			{
				case CSSToken.FUNCTION:
					tokenValue = tokenValue.substr(0, tokenValue.indexOf("("));
					break;
					
				case CSSToken.HASH:
					// remove # at beginning of identifier
					tokenValue = unescape(tokenValue.substr(1));
					break;
					
				case CSSToken.STRING:
					tokenValue = unescape(cleanString(tokenValue));
					break;
					
				case CSSToken.IDENTIFIER:
					tokenValue = unescape(tokenValue);
					break;
					
				case CSSToken.URI:
					
					// get value between parenthesis
					tokenValue = tokenValue.substring(tokenValue.indexOf("(") + 1, tokenValue.lastIndexOf(")"));
					
					if(tokenValue.length > 0)
					{
						// strip quotes and clean up escaped characters
						tokenValue = unescape(cleanString(tokenValue));
					}
					
					break;
					
				case CSSToken.AT_RULE:
					// remove beginnign @
					tokenValue = tokenValue.substr(1);
					break;
					
				default:
					break;
			}
			
			return new CSSToken(type, source, tokenValue, line, column);
		}
		
		public static function cleanString(value:String):String
		{
			// remove beginning and end quotes
			if(isQuote(value.charCodeAt(0)) && isQuote(value.charCodeAt(value.length - 1)))
			{
				value = value.substring(1, value.length - 1);
			}
			
			// clean up escaped characters
			return value;
		}
		
		public static function unescape(input:String):String
		{
			var i:int = 0;
			var len:int = input.length;
			var code:int;
			var result:String = "";
						
			while(i < len)
			{
				code = input.charCodeAt(i);
				
				if(isEscape(code))
				{
					// gobble escape char (/)
					i++;
					var unicode:String = matchUnicode(input.substr(i));
					
					if(unicode)
					{
						result += String.fromCharCode(parseInt(unicode, 16));
						i += unicode.length;
					}
					else
					{
						if(!isEscapedChar(input.charCodeAt(i)))
						{
							throw new CSSError("Invalid escape sequence", CSSErrorTypes.SAC_SYNTAX_ERR);
						}
					
						result += input.charAt(i);
						i++;
					}
				}
				else
				{
					result += input.charAt(i);
					i++;
				}
			}
			
			return result;
		}
		
		/*
			Token matching functions
		*/
		public static function matchWhitespace(input:String):String
		{
			var i:int = 0;
			
			while(isWhitespace(input.charCodeAt(i)))
			{
				i++;
			}
			
			return input.substr(0, i);
		}
		
		public static function matchIdentifier(input:String):String
		{
			// check for valid identifier start
			var start:String = matchNameStart(input);
			
			if(!start)
			{
				return null;
			}
			
			// skip valid start characters
			var i:int = start.length;
			var code:int;
			
			while(true)
			{
				code = input.charCodeAt(i);
				
				if(isEscape(code))
				{
					// gobble ecape (\)
					i++;
					var escape:String = matchEscape(input.substr(i));
					i += escape.length;
				}
				else if(isNmChar(code))
				{
					i++;
				}
				else
				{
					break;
				}
			}
			
			return input.substr(0, i);
		}
		
		public static function matchString(input:String):String
		{
			var i:int = 0;
			var code:int = input.charCodeAt(i);
			var open:int = code;
			var escape:String;
			
			// must have an open quote
			if(!isQuote(open))
			{
				return null;
			}
			
			// consume open quote
			i++;
			
			var len:int = input.length;
			
			while(i < len)
			{
				code = input.charCodeAt(i);
				
				// skip escaped characters
				if(isEscape(code))
				{
					i++;
					escape = matchEscape(input.substr(i));
					i += escape.length;
					
					continue;
				}
				
				// check for end quote 
				if(code == open)
				{
					break;
				}
				
				if(!isStringChar(code))
				{
					// no match. error?
					return null;
				}
				
				i++;
			}
			
			// should have broken from loop
			// before i == len
			// if we get here it means no matching end quote was found
			if(i == len)
			{
				return null;
			}
			
			// consume end quote
			i++;
			
			return input.substr(0, i);
		}
		
		public static function matchNumber(input:String):String
		{
			var i:int = 0;
			
			while(isNum(input.charCodeAt(i)))
			{
				i++;
			}
			
			// check for . and following number
			if(input.charAt(i) == "." && isNum(input.charCodeAt(i + 1)))
			{
				// skip .
				i++;
				
				// consume fraction
				while(isNum(input.charCodeAt(i)))
				{
					i++;
				}
			}
			
			return input.substr(0, i);
		}
		
		public static function matchComment(input:String):String
		{
			var i:int = 2;
			
			if(input.substr(0, i) != "/*")
			{
				return null;
			}
			
			var len:int = input.length;
			
			while(i < len)
			{
				// end when we encounter (*/)
				if(input.substr(i, 2) == "*/")
				{
					i += 2;
					break;
				}
				
				// gobble
				i++;
			}
			
			return input.substr(0, i);
		}
		
		public static function matchURI(input:String):String
		{
			var uriStart:String = "url(";
			var i:int = uriStart.length;
			
			if(input.substr(0, i) != uriStart)
			{
				return null;
			}
			
			var len:int = input.length;
			
			while(i < len)
			{
				if(input.charAt(i) == ")")
				{
					i++;
					break;
				}
				
				i++;
			}
			
			return input.substr(0, i);
		}
		
		public static function matchImportant(input:String):String
		{
			var i:int = 1;
			
			if(input.substr(0, i) != "!")
			{
				return null;
			}
			
			// ignore space between ! and important
			while(isWhitespace(input.charCodeAt(i)))
			{
				i++;
			}
			
			var important:String = "important";
			var len:int = important.length;
			
			if(input.substr(i, len) != important)
			{
				return null;
			}
			
			// consume important
			i += len;
			
			return input.substr(0, i);
		}
		
		public static function matchAtRule(input:String):String
		{
			// check for @
			if(input.charAt(0) != "@")
			{
				return null;
			}
			
			var ident:String = matchIdentifier(input.substr(1));
			
			if(!ident || !ident.length)
			{
				return null;
			}
			
			return "@" + ident;
		}
		
		public static function matchFunction(input:String):String
		{
			var ident:String = matchIdentifier(input);
			
			if(!ident || !ident.length)
			{
				return null;
			}
			
			var i:int = ident.length;
			
			if(input.charAt(i) != "(")
			{
				return null;
			}
			
			// consume (
			i++;
		
			return input.substr(0, i);
		}
		
		public static function matchHash(input:String):String
		{
			if(input.charAt(0) != "#")
			{
				return null;
			}
			
			var ident:String = matchIdentifier(input.substr(1));
			
			if(!ident || !ident.length)
			{
				return null;
			}
			
			return "#" + ident;
		}
		
		public static function matchHex(input:String):String
		{
			if(input.charAt(0) != "#")
			{
				return null;
			}
			
			var i:int = 1;
			
			while(isHex(input.charCodeAt(i)))
			{
				i++;
			}
			
			// hex must be 3 or 6 characters long (# + 3 or # + 6)
			if(i != 4 && i != 7)
			{
				return null;
			}
			
			return input.substr(0, i);
		}
		
		public static function matchNameStart(input:String):String
		{
			var i:int = 0;
			var code:int = input.charCodeAt(i);

			// check escape
			if(isEscape(code))
			{
				// gobble escape char (/);
				i++;
				
				var escape:String = matchEscape(input.substr(i));
			
				if(escape)
				{
					i += escape.length;
				}
			}
			else if(isHyphen(code))
			{
				// hyphen is a valid name start, but [hyphen][number] is reserved for negative number values
				// An identifer with a leading [hyphen][number] can be created by escaping the leading hyphen.
				
				i++;
				code = input.charCodeAt(i);
				
				if(isNum(code))
				{
					// no match
					return null;
				}
			}
			else if(isNmStart(code))
			{
				i++;
			}
			
			// no matches
			if(i == 0) return null;
			
			return input.substr(0, i);
		}
		
		public static function matchEscape(input:String):String
		{
			//escape    {unicode}|\\[^\n\r\f0-9a-f]
			var unicode:String = matchUnicode(input);
			
			if(unicode)
			{
				return unicode;
			}
			
			var code:int = input.charCodeAt(0);
			
			if(isEscapedChar(code))
			{
				return input.charAt(0);
			}
			
			// no escape matched
			return null;
		}
		
		public static function matchUnicode(input:String):String
		{
			// unicode   \\[0-9a-f]{1,6}(\r\n|[ \n\r\t\f])?
			var i:int = 0;
			var code:int;
			
			while(isHex(input.charCodeAt(i)))
			{
				i++;
			}
			
			// unicode must be between 1 and 6 characters
			if(i < 1 || i > 6)
			{
				return null;
			}
			
			if(isWhitespace(input.charCodeAt(i)))
			{
				i++;
			}
			
			return input.substr(0, i);
		}
		
		/* utilities */
		
		public static function isWhitespace(code:int):Boolean
		{
			switch(code)
			{
				case 0x09: // \t
				case 0x20: // [space]
					return true;
			}
			
			return isNewline(code);
		}
		
		public static function isNewline(code:int):Boolean
		{
			switch(code)
			{
				case 0x0A: // \n
				case 0x0C: // \f
				case 0x0D: // \r
					return true;
			}
			
			return false;
		}
		
		public static function isStringChar(code:int):Boolean
		{
			// newline, double and single quotes must be escaped in strings,
			// depending on open quote
			return !isNewline(code) && !isQuote(code);
		}
		
		public static function isEscape(code:int):Boolean
		{
			return code == 0x5C;
		}
		
		public static function isEscapedChar(code:int):Boolean
		{
			return !isHex(code);
		}
		
		public static function isQuote(code:int):Boolean
		{
			return (code == 0x22) || (code == 0x27);
		}
		
		public static function isNum(code:int):Boolean
		{
			return (code >= 0x30 && code <= 0x39);
		}
		
		public static function isNonAscii(code:int):Boolean
		{
			return (code >= 0x80 && code <= 0xFF); // {nonascii}
		}
		
		/**
		 * Determines whether code is a valid identifier beginning
		 */
		public static function isNmStart(code:int):Boolean
		{
			return isNonAscii(code)
				|| (code >= 0x41 && code <= 0x5A) // A-Z
				|| (code >= 0x61 && code <= 0x7A) // a-z
				|| (code == 0x5F || code == 0x2D); // _ or -
		}
		
		/**
		 * Determines whether code is a valid identifier character
		 */
		public static function isNmChar(code:int):Boolean
		{
			// {nmstart} or 0-9
			return isNmStart(code) || isNum(code);
		}
		
		public static function isHyphen(code:int):Boolean
		{
			return code == 0x2D;
		}
		
		public static function isHex(code:int):Boolean
		{
			return isNum(code)
				|| (code >= 0x41 && code <= 0x46) // A-F
				|| (code >= 0x61 && code <= 0x66); // a-f
		}
	}
}