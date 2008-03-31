package com.newgonzo.commons.parsing
{
	
	public class Tokenizer
	{
		private static var EOF_TOKEN:Token = new Token(Token.EOF);
		
		private var fullSource:String;
		private var remainingSource:String;
		
		private var tokenPatterns:Array;
		private var currentToken:Token;
		
		
		public function Tokenizer(source:String)
		{
			tokenPatterns = new Array();
			this.source = source;
		}
		
		public function set source(value:String):void
		{
			fullSource = value;
			reset();
		}
		
		public function get source():String
		{
			return fullSource;
		}
		
		public function get current():Token
		{
			return currentToken;
		}
		
		/* TODO: Really implement column and line */
		public function get column():int
		{
			return fullSource.length - remainingSource.length;
		}
		
		public function get line():int
		{
			return 1;
		}
		
		public function addTokenPattern(pattern:TokenPattern):void
		{
			tokenPatterns.push(pattern);
		}
		
		public function reset():void
		{
			remainingSource = fullSource;
			currentToken = null;
		}
		
		public function nextToken():Token
		{
			var next:Token = getNextToken(true);	
			
			if(!next && remainingSource.length > 0)
			{
				throw new ParseError("Tokenizer failed to make a match. Last good token was " + currentToken);
			}
			
			currentToken = next;
			return next;
		}
		
		public function skipToken():void
		{
			
		}
		
		public function lookAhead():Token
		{
			return getNextToken(false);
		}
		
		protected function getNextToken(consumeSource:Boolean = true):Token
		{
			// if no more source to scan, we're done
			if(remainingSource.length == 0)
			{
				return EOF_TOKEN;
			}
			
			var next:Token;
			var matchedSource:String;
			var longestMatch:int = 0;
			var matchResult:Array;
			var testPattern:TokenPattern;
			var matchedPattern:TokenPattern;
			var patternResult:String;
			
			for each(testPattern in tokenPatterns)
			{				
				matchResult = remainingSource.match(testPattern.pattern);
				
				if(!matchResult) continue;
				
				patternResult = matchResult[0];
				
				if(patternResult.length > longestMatch)
				{
					longestMatch = patternResult.length;
					matchedPattern = testPattern;
					matchedSource = patternResult;
				}
			}
			
			if(matchedPattern)
			{
				next = createToken(matchedPattern, matchedSource, column, currentToken);
				
				// implementation override determines this token is expendable
				if(!next)
				{
					consume(matchedSource.length);
					return getNextToken(consumeSource);
				}
				
				if(consumeSource)
				{
					consume(matchedSource.length);
				}
				
				return next;
			}
			
			return null;
		}
		
		
		/** 
		* Removes N characters from the front of the remaining source
		* to tokenize.
		*/
		protected function consume(chars:int = 1):void
		{
			remainingSource = remainingSource.substr(chars);
		}
		
		protected function createToken(pattern:TokenPattern, value:String, sourceIndex:int, prevToken:Token = null):Token
		{
			return new Token(pattern.type, value, sourceIndex);
		}
	}
}