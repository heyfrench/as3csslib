package com.newgonzo.web.css.net
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class DefaultRequestHandler implements IRequestHandler
	{
		protected var urlRequeset:URLRequest;
		protected var loader:URLLoader;
		protected var handleComplete:Function;
		protected var handleError:Function;
		
		protected var loadedData:*;
		protected var errorData:*;
		
		public function DefaultRequestHandler(request:URLRequest)
		{
			urlRequeset = request;
		}
		
		public function get request():URLRequest
		{
			return urlRequeset;
		}
		
		public function get data():*
		{
			return loadedData;
		}
		
		public function get error():*
		{
			return errorData;
		}

		public function load(completeHandler:Function, errorHandler:Function):void
		{
			handleComplete = completeHandler;
			handleError = errorHandler;
			
			loader = new URLLoader(request);
			
			loader.addEventListener(Event.COMPLETE, handleLoadComplete, false, 0, true);
			loader.addEventListener(IOErrorEvent.IO_ERROR, handleLoadError, false, 0, true);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleLoadError, false, 0, true);
		}
		
		protected function doComplete():void
		{
			try
			{
				handleComplete(this);
			}
			catch(e:Error)
			{
				errorData = e.message;
				doError();
			}
			finally
			{
				doCleanup();
			}
		}
		
		protected function doError():void
		{
			try
			{
				handleError(this);
			}
			catch(e:Error)
			{
				errorData = e.message;
			}
			finally
			{
				doCleanup();
			}
		}
		
		protected function doCleanup():void
		{
			if(loader)
			{
				loader.removeEventListener(Event.COMPLETE, handleLoadComplete);
				loader.removeEventListener(IOErrorEvent.IO_ERROR, handleLoadError);
				loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, handleLoadError);
				loader = null;
				handleComplete = null;
				handleError = null;
			}
		}
		
		private function handleLoadComplete(event:Event):void
		{
			var loader:URLLoader = event.target as URLLoader;
			loadedData = loader.data;
			doComplete();
		}
		
		private function handleLoadError(event:ErrorEvent):void
		{
			errorData = event.text;
			doError();
		}
	}
}