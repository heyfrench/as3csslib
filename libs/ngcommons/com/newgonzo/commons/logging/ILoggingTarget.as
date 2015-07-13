package com.newgonzo.commons.logging
{
	public interface ILoggingTarget
	{
		function get level():int
		function set level(level:int):void
		
		function get filter():RegExp
		function set filter(value:RegExp):void	
		
		function addLogger(logger:ILogger):void
		function removeLogger(logger:ILogger):void
	}
}