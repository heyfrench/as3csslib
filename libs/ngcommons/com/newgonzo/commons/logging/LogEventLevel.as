package com.newgonzo.commons.logging
{
	public class LogEventLevel
	{
		public static const ALL:int = 0;
		public static const DEBUG:int = 2;
		public static const INFO:int = 4;
		public static const WARN:int = 6;
		public static const ERROR:int = 8;
		public static const FATAL:int = 1000;
		
		public static function toString(level:int):String
		{
			switch(level)
			{
				case ALL:
					return "ALL";
				case DEBUG:
					return "DEBUG";
				case INFO:
					return "INFO";
				case WARN:
					return "WARN";
				case ERROR:
					return "ERROR";
				case FATAL:
					return "FATAL";
			}
			
			return "";
		}
		
		public static function fromString(st:String):int
		{
			switch(st.toLowerCase())
			{
				case "all":
					return ALL;
				case "debug":
					return DEBUG;
				case "info":
					return INFO;
				case "warn":
					return WARN;
				case "error":
					return ERROR;
				case "fatal":
					return FATAL;
				default:
					return -1;
			}
		}
	}
}