package com.newgonzo.web.css.parser
{
	import org.w3c.css.sac.CSSParseError;
	import org.w3c.css.sac.IErrorHandler;

	public class DefaultErrorHandler implements IErrorHandler
	{
		public static const INSTANCE:DefaultErrorHandler = new DefaultErrorHandler();
		
		public function error(error:CSSParseError):void
		{
			//trace("ERROR: " + error);
		}
		
		public function fatalError(error:CSSParseError):void
		{
			//trace("FATAL: " + error);	
		}
		
		public function warning(error:CSSParseError):void
		{
			//trace("WARNING: " + error);
		}
	}
}
