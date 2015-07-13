package com.newgonzo.commons.logging.logcentral
{
	import com.newgonzo.commons.logging.LogEventLevel;
	
	public class LogCentralMessage
	{
		public var index:int;
		public var time:int;
		public var category:String;
		public var message:String;
		public var level:int
		
		public function toString():String
		{
			return index.toString() + ":" + time.toString() + " [" + LogEventLevel.toString(level) + "] " + category + ": " + message;
		}
	}
}