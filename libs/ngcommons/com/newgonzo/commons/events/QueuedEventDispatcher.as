package com.newgonzo.commons.events
{
	import flash.events.*;
	
	/**
	 * Main logger class
	 * 
	 * @author john
	 */
	public class QueuedEventDispatcher extends EventDispatcher
	{	
		private var eventQueue:Array;
		
		public function QueuedEventDispatcher(proxy:IEventDispatcher = null)
		{
			super(proxy);
			this.eventQueue = new Array();
		}
		
		public override function dispatchEvent(event:Event):Boolean
		{
			if(this.hasEventListener(event.type))
			{
				return super.dispatchEvent(event);
			}
			else
			{
				// queue the event
				this.eventQueue.push(event);
				return false;
			}
		}
		
		/**
		 * Override <code>EventDispatcher.addEventListener()</code> so
		 * we can check our queue for events that were stored when no
		 * listeners were present.
		 */
		public override function addEventListener(type:String, handler:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			super.addEventListener(type, handler, useCapture, priority, useWeakReference);
			
			var len:Number = this.eventQueue.length;
			
			for(var i:Number=0; i<len; i++)
			{
				var evt:Event = Event(this.eventQueue[i]);
				
				if(this.hasEventListener(evt.type))
				{
					
					super.dispatchEvent(evt);
				}
			}
		}
	}
}