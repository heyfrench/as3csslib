package com.newgonzo.commons.parsing
{
	
	public class TokenPattern
	{
		private var tokenType:int;
		private var tokenPattern:RegExp;
		private var resultCaptureGroup:uint;
		
		public function TokenPattern(type:int, pattern:RegExp, captureGroup:uint = 0)
		{
			tokenType = type;
			tokenPattern = pattern;
			resultCaptureGroup = captureGroup;
		}
		
		public function get type():int
		{
			return tokenType;
		}
		
		public function get pattern():RegExp
		{
			return tokenPattern;
		}
		
		public function get captureGroup():uint
		{
			return resultCaptureGroup;
		}
		
		public function toString():String
		{
			return "[TokenPattern(type=" + tokenType + " pattern=" + tokenPattern + ")]";
		}
	}
}