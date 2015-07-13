package com.newgonzo.commons.logging.targets
{
	import com.newgonzo.commons.logging.*;
	
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	import flash.utils.getTimer;
		
	public class LocalConnectionTarget extends LineFormattedTarget
	{
		private var methodName:String;
		private var connectionId:String;
		
		private var count:int = 0;
		private var lc:LocalConnection;
	
		public function LocalConnectionTarget(connection:String, method:String = "dispatchMessage")
		{
			super();
			
			includeCategory = true;
			connectionId = connection;
			methodName = method;
			
			connect();
		}
		
		override public function logEvent(event:LogEvent):void
		{
			var level:int = event.level;
			var category:String = includeCategory ? ILogger(event.target).category : "";
			
			sendMessage(event.message, category, level);
		}
		
		public function connect():void
		{
			disconnect();
			
			lc = new LocalConnection();
			lc.addEventListener(StatusEvent.STATUS, statusEventHandler, false, 0, true);
		}
		
		public function disconnect():void
		{
			if(lc)
			{
				//lc.removeEventListener(StatusEvent.STATUS, statusEventHandler);
				lc = null;
			}
		}
		
		protected function send(methodName:String, ...args):void
		{
			try
			{
				lc.send.apply(null, [connectionId, methodName, count].concat(args));
				count++;
			}
			catch(error:Error)
			{
				trace("Logging failed: " + error);
			}
		}
		
		protected function sendMessage(message:String, category:String, level:int):void
		{
			send(methodName, getTimer(), message, category, level);
		}
		
		protected function resetCount():void
		{
			count = 0;
		}
		
		private function statusEventHandler(event:StatusEvent):void
		{
			
		}
	}
}