package com.newgonzo.web.css.net
{
	import flash.net.URLRequest;
	
	public interface IRequestHandler
	{
		function get data():*
		function get error():*
		function load(completeHandler:Function, errorHandler:Function):void
	}
}