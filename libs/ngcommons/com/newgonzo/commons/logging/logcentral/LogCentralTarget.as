package com.newgonzo.commons.logging.logcentral
{
	import com.newgonzo.commons.logging.targets.LocalConnectionTarget;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExternalInterface;
	import flash.net.LocalConnection;
	
	public class LogCentralTarget extends LocalConnectionTarget implements IEventDispatcher
	{
		public static const RESET:String = "RESET";
		
		private var infoMethodName:String;
		
		private var returnConnection:LocalConnection;
		private var receivingId:String;
		
		private var dispatcher:EventDispatcher;
		
		public function LogCentralTarget(sendConnectionId:String = "_logCentralReceiving", receiveConnectionId:String = "_logCentralSending", logMethod:String = "logMessage", infoMethod:String = "logValue")
		{
			infoMethodName = infoMethod;
			receivingId = receiveConnectionId;
			
			super(sendConnectionId, logMethod);
			
			dispatcher = new EventDispatcher(this);
			
			sendReset();
		}
		
		public function sendReset():void
		{
			resetCount();
			
			// send first message indicating the use of the BanditoLogTarget
			// this also ensures message 0 (the "reset" message) is always sent
			sendInfo(RESET, (new Date()).toDateString());
		}
		
		public function logEnvironment():void
		{
			if(ExternalInterface.available)
			{
				var ua:String = ExternalInterface.call("window.navigator.userAgent.toString");
				var location:String = ExternalInterface.call("window.location.href.toString");
				
				sendInfo(LogCentralEnvironment.USER_AGENT, ua);
				sendInfo(LogCentralEnvironment.LOCATION, location);
			}
			
			dispatchEvent(new LogCentralEvent(LogCentralEvent.ENVIRONMENT));
		}
		
		public function sendInfo(key:String, value:String):void
		{
			send(infoMethodName, key, value);
		}
		
		override public function connect():void
		{
			super.connect();
			
			try
			{
				trace("LogCentralTarget connecting to " + receivingId);
				returnConnection = new LocalConnection();
				returnConnection.addEventListener(StatusEvent.STATUS, statusReceived, false, 0, true);
				returnConnection.allowDomain("*");
				returnConnection.connect(receivingId);
				returnConnection.client = this;
			}
			catch(e:Error)
			{
				trace("Error establishing LocalConnection: " + e.getStackTrace());
			}
		}
		
		override public function disconnect():void
		{
			super.disconnect();
			
			try
			{
				if(returnConnection)
				{
					returnConnection.close();
					returnConnection = null;
				}
			}
			catch(e:Error)
			{
				trace("Error closing connection: " + e.getStackTrace());
			}
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			dispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			return dispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return dispatcher.hasEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean
		{
			return dispatcher.willTrigger(type);
		}
		
		private function statusReceived(event:StatusEvent):void
		{
			trace("status: " + event);
		}
	}
}