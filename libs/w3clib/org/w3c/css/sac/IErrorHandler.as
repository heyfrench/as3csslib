package org.w3c.css.sac
{
	public interface IErrorHandler
	{
		function error(error:CSSParseError):void
		function fatalError(error:CSSParseError):void
		function warning(error:CSSParseError):void
	}
}
