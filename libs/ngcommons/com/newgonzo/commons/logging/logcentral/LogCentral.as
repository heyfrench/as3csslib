package com.newgonzo.commons.logging.logcentral
{
	import com.newgonzo.commons.logging.LogEventLevel;
	
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	import flash.utils.getTimer;
	
	public class LogCentral extends EventDispatcher
	{
		public static const SENDING_CONNECTION_ID:String = "_logCentralSending";
		public static const RECEIVING_CONNECTION_ID:String = "_logCentralReceiving";
		
		public static const LOG_ENVIRONMENT_METHOD:String = "logEnvironment";
		
		private var receivingId:String;
		private var sendingId:String;
		
		private var receivingConnection:LocalConnection;
		private var sendingConnection:LocalConnection;
		
		private var connected:Boolean = false;
		
		// the LogProxy's log index is its way of
		// staying in sync with the app it's receiving messages
		// from. if ever there's a deviation, we can notify the user
		private var expectedIndex:int = 0;
		
		private var indexSyncEnabled:Boolean = true;
		private var hasSync:Boolean = false;
		
		// the info object represents environment
		// properties sent to Bandito from the logging target
		private var info:Object;
		
		public function LogCentral(receivingConnectionId:String = RECEIVING_CONNECTION_ID, sendingConnectionId:String = SENDING_CONNECTION_ID)
		{
			receivingId = receivingConnectionId;
			sendingId = sendingConnectionId;
			
			connect();
		}
		
		public function set syncEnabled(value:Boolean):void
		{
			indexSyncEnabled = value;
		}
		public function get syncEnabled():Boolean
		{
			return indexSyncEnabled;
		}
		
		public function get inSync():Boolean
		{
			return hasSync;
		}
		
		public function reset():void
		{
			info = null;
			hasSync = false;
			expectedIndex = 0;
		}
		
		public function queryEnvironment():void
		{
			trace("queryEnvironment()");
			
			try
			{
				if(connected)
				{
					sendingConnection.send(sendingId, LOG_ENVIRONMENT_METHOD);
				}
				else
				{
					throw new Error("Not connected.");
				}
			}
			catch(e:Error)
			{
				trace("Error querying environment: " + e.getStackTrace());
			}
		}
		
		public function getValue(key:String):String
		{
			return info && info.hasOwnProperty(key) && info[key] !== null ? info[key].toString() : "";
		}
		
		public function setValue(key:String, value:String):void
		{
			if(!info)
			{
				info = new Object();
			}
				
			info[key] = value;
		}
		
		public function logValue(index:int, key:String, value:String):void
		{
			var msg:LogCentralMessage = createMessage(index, getTimer(), value, key, LogEventLevel.INFO);
			
			if(!msg) return;
			
			setValue(key, value);
			
			dispatchEvent(new LogCentralEvent(LogCentralEvent.VALUE, msg));
			dispatchEvent(new LogCentralEvent(LogCentralEvent.MESSAGE, msg));
		}
		
		/**
		 * Called by the logging target class via local connection
		 */			
		public function logMessage(index:int, time:int, message:String, category:String, level:int):void
		{
			var msg:LogCentralMessage = createMessage(index, time, message, category, level);
			
			if(!msg) return;
			
			dispatchEvent(new LogCentralEvent(LogCentralEvent.MESSAGE, msg));
		}
		
		protected function createMessage(index:int, time:int, message:String, category:String, level:int):LogCentralMessage
		{
			// if this is the first message the connected app
			// is sending (index 0), clear the previous messages
			// and ignore the "RESET" message
			//trace("index: " + index + " expected: " + expectedIndex);
			
			setIndex(index);
			
			if(!hasSync)
			{
				return null;
			}
			
			// Logging to panel
			// (top down)
			var msg:LogCentralMessage = new LogCentralMessage();
			msg.index = index;
			msg.time = time;
			msg.category = category;
			msg.message = message;
			msg.level = level;
			
			return msg;
		}
		
		protected function connect():void
		{
			trace("connect()");
			
			disconnect();
			
			try
			{
				trace("LogCentral connecting to " + receivingId);
				receivingConnection = new LocalConnection();
				receivingConnection.addEventListener(StatusEvent.STATUS, statusEvent, false, 0, true);
				receivingConnection.allowDomain("*");
				receivingConnection.connect(receivingId);
				receivingConnection.client = this;
				
				sendingConnection = new LocalConnection();
				sendingConnection.addEventListener(StatusEvent.STATUS, statusEvent, false, 0, true);
				
				connected = true;
			}
			catch(e:Error)
			{
				trace("Error establishing LocalConnections: " + e.getStackTrace());
				connected = false;
			}
		}
		
		protected function disconnect():void
		{
			try
			{
				if(receivingConnection)
				{
					receivingConnection.close();
				}
				
				if(sendingConnection)
				{
					sendingConnection.removeEventListener(StatusEvent.STATUS, statusEvent);
				}
			}
			catch(e:Error)
			{
				trace("Error closing connection: " + e.getStackTrace());
			}
			
			connected = false;
		}
		
		private function setIndex(index:int):void
		{
			if(!indexSyncEnabled)
			{
				hasSync = true;
				return;
			}
			
			if(!checkIndex(index))
			{
				hasSync = false;
				dispatchEvent(new LogCentralEvent(LogCentralEvent.SYNC_ERROR));
				return;
			}
			
			if(index == 0)
			{
				reset();
				
				// send notification informing app
				// we're in sync with a reporting app
				hasSync = true;
				
				dispatchEvent(new LogCentralEvent(LogCentralEvent.SYNC));
			}
			
			expectedIndex++;
		}
		
		private function checkIndex(value:int):Boolean
		{
			return !indexSyncEnabled || value == 0 || value == expectedIndex;
		}
		
		private function statusEvent(event:StatusEvent):void
		{
		}
	}
}