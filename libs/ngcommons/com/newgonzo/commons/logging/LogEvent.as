package com.newgonzo.commons.logging
{
	import flash.events.*;
	
	public class LogEvent extends Event
	{
		public static const LOG:String = "log";
		
		private var logMessage:String;
		private var logLevel:int;
		private var logCategory:String;
		
		private var timestamp:Date;
	
		public function LogEvent(message:String, level:int, category:String)
		{
			super(LogEvent.LOG);
			
			logMessage = message;
			logLevel = level;
			logCategory = category;
			
			timestamp = new Date();
		}
		
		public override function clone():Event
		{
			return new LogEvent(logMessage, logLevel, logCategory);
		}
		
		public function get message():String
		{
			return logMessage;
		}
		
		public function get level():int
		{
			return logLevel;
		}
		
		public function get category():String
		{
			return logCategory;
		}
		
		public static function getLevelString(level:int):String
		{
			switch(level)
			{
				case LogEventLevel.ALL:
					return "ALL";
				case LogEventLevel.DEBUG:
					return "DEBUG";
				case LogEventLevel.ERROR:
					return "ERROR";
				case LogEventLevel.FATAL:
					return "FATAL";
				case LogEventLevel.INFO:
					return "INFO";
				case LogEventLevel.WARN:
					return "WARN";
				default:
					return "NONE";
			}
		}
		
		public override function toString():String
		{
			var s:String = "";//(timestamp.getMonth() + 1) + "/" + timestamp.getDate() + "/" + timestamp.getFullYear();
			//s += " " + timestamp.getHours() + ":" + timestamp.getMinutes() + ":" + timestamp.getSeconds();
			s += "[" + LogEvent.getLevelString(logLevel) + "]";
			s += "(" + logCategory.substr(logCategory.lastIndexOf(".") + 1) + ")";
			s+= ": " + logMessage;
	
			return s;	
		}
	}
}