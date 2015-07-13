package com.newgonzo.commons.logging
{
	import flash.events.*;
	import com.newgonzo.commons.events.*;
	
	public class LogLogger extends QueuedEventDispatcher implements ILogger
	{	
		private var loggerCat:String;
		
		public function LogLogger(category:String)
		{
			loggerCat = category;
		}
		
		public function get category():String
		{
			return loggerCat;
		}
		
		public function debug(message:String, ...rest):void
		{
			log(LogEventLevel.DEBUG, parseMessage(message, rest));
		}
		
		public function info(message:String, ...rest):void
		{
			log(LogEventLevel.INFO, parseMessage(message, rest));
		}
		
		public function error(message:String, ...rest):void
		{
			log(LogEventLevel.ERROR, parseMessage(message, rest));
		}
		
		public function warn(message:String, ...rest):void
		{
			log(LogEventLevel.WARN, parseMessage(message, rest));
		}
		
		public function fatal(message:String, ...rest):void
		{
			log(LogEventLevel.FATAL, parseMessage(message, rest));
		}
		
		public function log(level:int, message:String, ...rest):void
		{
			if (level < LogEventLevel.DEBUG)
			{
				throw new ArgumentError("Log level cannot be less than LogEventLevel.DEBUG");
			}
				
			if (hasEventListener(LogEvent.LOG))
			{
				var msg:String = message;
				
				if(rest.length > 0)
				{
					msg = parseMessage(message, rest);
				}

				dispatchEvent(new LogEvent(msg, level, category));
			}
		}
		
		/**
		 * 
		 */
		private function parseMessage(message:String, args:Array):String
		{
			if(args.length == 0)
			{
				return message;
			}
			
			var msg:String = message;
			
			for (var i:int=0; i<args.length; i++)
			{
				msg = msg.replace(new RegExp("\\{"+i+"\\}", "g"), args[i]);
			}
			
			return msg;
		}
	}
}