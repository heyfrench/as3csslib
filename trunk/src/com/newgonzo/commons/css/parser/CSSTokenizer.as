package com.newgonzo.commons.css.parser
{
	import com.newgonzo.commons.parsing.Token;
	import com.newgonzo.commons.parsing.TokenPattern;
	import com.newgonzo.commons.parsing.Tokenizer;
	
	public class CSSTokenizer extends Tokenizer
	{
		public function CSSTokenizer(source:String)
		{
			super(source);
			
			addTokenPattern(new TokenPattern(CSSToken.SPACE, /^[\s\t\n]+/));
			addTokenPattern(new TokenPattern(CSSToken.COMMENT, /^\/\*(.|[\r\n])*?\*\//));
			addTokenPattern(new TokenPattern(CSSToken.IDENTIFIER, /^[a-zA-Z_][a-zA-Z0-9_-]*/));
			addTokenPattern(new TokenPattern(CSSToken.STRING, /^'[^']*'|^"[^"]*"/));
			addTokenPattern(new TokenPattern(CSSToken.NUMBER, /^[0-9]+|^[0-9]*\.[0-9]+/));
			addTokenPattern(new TokenPattern(CSSToken.FUNCTION, /^[a-zA-Z_][a-zA-Z0-9_-]*\(/));
			addTokenPattern(new TokenPattern(CSSToken.NOT, /^:not\(/));
			addTokenPattern(new TokenPattern(CSSToken.HASH, /^#[a-zA-Z_][a-zA-Z0-9_-]*/));
			
			addTokenPattern(new TokenPattern(CSSToken.PRECEDE, /^>/));
			addTokenPattern(new TokenPattern(CSSToken.LEFT_BRACKET, /^\[/));
			addTokenPattern(new TokenPattern(CSSToken.RIGHT_BRACKET, /^\]/));
			addTokenPattern(new TokenPattern(CSSToken.LEFT_BRACE, /^\(/));
			addTokenPattern(new TokenPattern(CSSToken.RIGHT_BRACE, /^\)/));
		
			addTokenPattern(new TokenPattern(CSSToken.COLON, /^:/));
			addTokenPattern(new TokenPattern(CSSToken.ANY, /^\*/));
			addTokenPattern(new TokenPattern(CSSToken.EQUAL, /^=/));
			addTokenPattern(new TokenPattern(CSSToken.COMMA, /^,/));
			addTokenPattern(new TokenPattern(CSSToken.DOT, /^\./));
			addTokenPattern(new TokenPattern(CSSToken.PLUS, /^\+/));
			addTokenPattern(new TokenPattern(CSSToken.MINUS, /^-/));
			addTokenPattern(new TokenPattern(CSSToken.DIVIDE, /^\//));
			addTokenPattern(new TokenPattern(CSSToken.SEMI_COLON, /^;/));
			addTokenPattern(new TokenPattern(CSSToken.TILDE, /^~/));
			addTokenPattern(new TokenPattern(CSSToken.VERTICAL_BAR, /^\|/));
			addTokenPattern(new TokenPattern(CSSToken.PERCENT, /^%/));
			
			addTokenPattern(new TokenPattern(CSSToken.DASHMATCH, /^\|=/));
			addTokenPattern(new TokenPattern(CSSToken.INCLUDES, /^\~=/));
			addTokenPattern(new TokenPattern(CSSToken.PREFIXMATCH, /^\^=/));
			addTokenPattern(new TokenPattern(CSSToken.SUFFIXMATCH, /^\$=/));
			addTokenPattern(new TokenPattern(CSSToken.SUBSTRINGMATCH, /^\*=/));
			
			// so we can parse whole style sheets before we implement value parsing
			addTokenPattern(new TokenPattern(CSSToken.LEFT_CURLY_BRACE, /^\{/));
			addTokenPattern(new TokenPattern(CSSToken.RIGHT_CURLY_BRACE, /^\}/));
			
			addTokenPattern(new TokenPattern(CSSToken.HEXADECIMAL, /^(#([0-9A-Fa-f]{3,6})\b)/));
		}
		
		
		
		override protected function createToken(pattern:TokenPattern, value:String, sourceIndex:int, prevToken:Token = null):Token
		{
			var tokenValue:String = value;
			
			switch(pattern.type)
			{
				// leave it up to the parser to determine whether these tokens should be discarded.
				case CSSToken.SPACE:
				case CSSToken.COMMENT:
					//return null;
					break;
					
				case CSSToken.FUNCTION:
					// strip trailing right brace (parenthesis)
					tokenValue = tokenValue.match(/^[^\(]+/)[0];
					break;
					
				case CSSToken.HASH:
					// remove # at beginning of identifier
					tokenValue = tokenValue.substr(1);
					break;
					
				case CSSToken.STRING:
					// remove beginning and end quotes as they're unneeded
					tokenValue = tokenValue.match(/^['"]([^'"]*)['"]$/)[1];
					break;
					
				default:
					break;
			}
			
			return new CSSToken(pattern.type, tokenValue, sourceIndex);
		}
	}
}