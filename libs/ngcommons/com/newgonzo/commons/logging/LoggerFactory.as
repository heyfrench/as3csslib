package com.newgonzo.commons.logging
{
	public class LoggerFactory
	{
		public function createLogger(category:String):ILogger
		{
			return new LogLogger(category);
		}
	}
}