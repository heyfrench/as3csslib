package org.w3c.css.sac
{
	import flash.utils.ByteArray;
	
	public interface IInputSource
	{
		function get byteStream():ByteArray
		function set byteStream(value:ByteArray):void
		
		function get characterStream():String
		function set characterStream(value:String):void
		
		function get encoding():String
		function set encoding(value:String):void
		
		function get media():String
		function set media(value:String):void
		
		function get title():String
		function set title(value:String):void
		
		function get uri():String
		function set uri(value:String):void
	}
}