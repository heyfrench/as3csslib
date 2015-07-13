package com.newgonzo.commons.logging.targets
{
	import com.newgonzo.commons.logging.*;
	
	public class TraceTarget extends AbstractTarget implements ILoggingTarget
	{
		public override function logEvent(event:LogEvent):void
		{
			trace(event.toString());		
		}
		
	}
}