package com.newgonzo.commons.logging.targets
{
	import com.newgonzo.commons.logging.*;
	import adobe.utils.*;
	
	
	/**
	 * Logs messages to the Flash IDE's trace window when the application
	 * is running as a WindowSWF
	 *
	 * @author john
	 */
	public class JSFLTraceTarget extends AbstractTarget implements ILoggingTarget
	{
		/**
		 * Sends the message to the Flash IDE output window.
		 * 
		 * @param oMessage Message object to send
		 */
		public override function logEvent(event:LogEvent):void
		{
			MMExecute("fl.trace(\"" + event.toString().split("\"").join("\\\"") + "\");");	
		}
		
	}
}