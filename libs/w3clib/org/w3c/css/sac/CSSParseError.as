package org.w3c.css.sac
{
	import org.w3c.css.sac.CSSError;		

	public class CSSParseError extends CSSError
	{
		public var lineNumber:int;
		public var columnNumber:int;
		public var uri:String;
		
		public function CSSParseError(message:String, code:int, line:int = 0, column:int = 0, cssUri:String = null, error:Error = null)
		{
			super(message, code, error);
			lineNumber = line;
			columnNumber = column;
			uri = cssUri;
			name = "CSSParseError";
		}
		
		/*
		public function toString():String
		{
			return "[CSSParseError(message=\"" + message + "\" lineNumber=" + lineNumber + " columnNumber=" + columnNumber + ")]";
		}
		*/
	}
}