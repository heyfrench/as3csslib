package com.newgonzo.web.css
{
	import org.w3c.css.sac.CSSParseError;
	import org.w3c.css.sac.IErrorHandler;
	
	public class CSSErrorHandler implements IErrorHandler
	{
		protected var document:ICSSDocument;
		
		public function CSSErrorHandler(cssDocument:ICSSDocument)
		{
			document = cssDocument;
		}
		
		public function error(error:CSSParseError):void
		{
			// TODO: better place for this?
			error.uri = document.uri;
			document.errors.push(error);
		}
		
		public function fatalError(error:CSSParseError):void
		{
			// TODO: better place for this?
			error.uri = document.uri;
			document.errors.push(error);
		}
		
		public function warning(error:CSSParseError):void
		{
			// TODO: better place for this?
			error.uri = document.uri;
			document.warnings.push(error);
		}

	}
}