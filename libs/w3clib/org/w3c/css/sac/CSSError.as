package org.w3c.css.sac
{
	public class CSSError extends Error
	{
		public var error:Error;
		public var code:int;
		
		public function CSSError(message:String="", id:int=0, internalError:Error=null)
		{
			super(message, id);
			code = id;
			error = internalError;
			name = "CSSError";
			
			// tmp
			if(error)
			{
				//trace(error.getStackTrace());
			}
		}
	}
}