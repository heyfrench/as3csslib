package com.newgonzo.commons.parsing
{
	
	public class Tokenizer
	{
		private static const EOF_TOKEN:Token = new Token(Token.EOF);
		
		private var fullSource:String;
		private var remainingSource:String;
		
		private var currentToken:Token;
		
		private var currentColumn:int = 1;
		private var currentLine:int = 1;
		
		public function Tokenizer(source:String)
		{
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
			return currentColumn;
		}
		
		public function get line():int
		{
			return currentLine;
		}
		
		public function nextToken():Token
		{
			var next:Token = getNextToken(true);	
			currentToken = next;
			return next;
		}
		
		public function lookAhead():Token
		{
			return getNextToken(false);
		}
		
		public function reset():void
		{
			remainingSource = fullSource;
			currentToken = null;
			currentColumn = 1;
			currentLine = 1;
		}
		
		public function recover():void
		{
			// cosume single characters until a valid
			// token production can be made
			while(getNextToken(false).type == Token.UNKNOWN)
			{
				consume();
			}
		}
		
		protected function getNextToken(consumeSource:Boolean = true):Token
		{
			// if no more source to scan, we're done
			if(remainingSource.length == 0)
			{
				return createToken(Token.EOF, null, currentLine, currentColumn, currentToken);
			}
			
			var patterns:Array = tokenPatterns;
			var next:Token;
			var testPattern:TokenPattern;
			var patternResult:String;
			
			for each(testPattern in patterns)
			{				
				patternResult = testPattern.match(remainingSource);
				
				if(patternResult)
				{
					next = createToken(testPattern.type, patternResult, currentLine, currentColumn, currentToken);
				
					if(!next)
					{
						// ignored
						consume(patternResult.length);
						return getNextToken(consumeSource);
					}
					
					if(consumeSource)
					{
						consume(patternResult.length);
					}
					
					return next;
				}
			}
			
			// no match
			// createa an UNKNOWN token with the curious value
			var char:String = remainingSource.charAt(0);
			consume();
			return createToken(Token.UNKNOWN, char, currentLine, currentColumn, currentToken);
		}
		
		protected function get tokenPatterns():Array
		{
			return null;
		}
		
		/** 
		* Removes N characters from the front of the remaining source
		* to tokenize.
		*/
		protected function consume(length:int = 1):void
		{
			var consumed:String = remainingSource.substr(0, length);
			
			var i:int = 0;
			var len:int = consumed.length;
			var code:int;
			
			while(i < len)
			{
				code = consumed.charCodeAt(i);
				
				// \n \f \r
				if(code == 0x0A || code == 0x0C || code == 0x0D)
				{
					currentColumn = 1;
					currentLine++;
				}
				else
				{
					currentColumn++;
				}
				
				i++;
			}
			
			remainingSource = remainingSource.substr(length);
		}
		
		protected function createToken(type:int, source:String, line:int = -1, column:int = -1, prevToken:Token = null):Token
		{
			return new Token(type, source, source, line, column, prevToken);
		}
	}
}