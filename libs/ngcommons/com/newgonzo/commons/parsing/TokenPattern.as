package com.newgonzo.commons.parsing
{
	
	public class TokenPattern
	{
		private var tokenType:int;
		private var patternChunkSize:int;
		
		private var matchString:String;
		private var matchPattern:RegExp;
		private var matchFunc:Function;

		private var cleanPattern:RegExp;
		private var cleanFunc:Function;
		
		public function TokenPattern(type:int, match:*, clean:* = null, regExpChunkSize:int = -1)
		{
			tokenType = type;
			
			if(match is Function) 
			{
				matchFunc = match as Function;
			}
			else if(match is RegExp)
			{
				matchPattern = match as RegExp;
			}
			else
			{
				matchString = match as String;
			}
			
			if(clean is RegExp)
			{
				cleanPattern = clean as RegExp;
			}
			else
			{
				cleanFunc = clean as Function;
			}
			
			/// Regular expressions are horribly (exponentially) slow on long strings. 
			// If a regex has to be used, limiting the size of the part of the stream that it
			// operates on helps
			patternChunkSize = regExpChunkSize;
		}
		
		public function get type():int
		{
			return tokenType;
		}
		
		public function match(input:String):String
		{
			// try to match string first
			if(matchString)
			{
				return input.substr(0, matchString.length) == matchString ? matchString : null;
			}
			
			// try match function
			if(matchFunc != null)
			{
				return matchFunc(input) as String;
			}
			
			// try match pattern
			if(matchPattern)
			{
				var chunk:String = patternChunkSize > 0 ? input.substr(0, patternChunkSize) : input;
				var result:Array = chunk.match(matchPattern);
				return result ? result[0] : null;
			}
			
			return null;
		}
		
		public function clean(input:String):String
		{
			if(cleanPattern != null)
			{
				var result:Array = input.substr(0, patternChunkSize).match(cleanPattern);
				return result ? result[0] : null;
			}
			
			if(cleanFunc != null)
			{
				return cleanFunc(input) as String;
			}
			
			return input;
		}
		
		public function toString():String
		{
			return "[TokenPattern(type=" + tokenType + ")]";
		}
	}
}