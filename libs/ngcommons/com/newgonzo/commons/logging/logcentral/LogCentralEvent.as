package com.newgonzo.commons.logging.logcentral
{
	import flash.events.Event;
	
	public class LogCentralEvent extends Event
	{
		public static const MESSAGE:String = "logMessage";
		public static const VALUE:String = "logValue";
		public static const SYNC:String = "logSync";
		public static const SYNC_ERROR:String = "logSyncError";
		public static const ENVIRONMENT:String = "logEnvironment";
		
		private var logMessage:LogCentralMessage;
		
		public function LogCentralEvent(type:String, message:LogCentralMessage = null)
		{
			super(type, false, true);
			
			logMessage = message;
		}
		
		public function get message():LogCentralMessage
		{
			return logMessage;
		}
		
		override public function clone():Event
		{
			return new LogCentralEvent(type, logMessage);
		}
		
		override public function toString():String
		{
			return formatToString("LogCentralEvent", "message");
		}
	}
}