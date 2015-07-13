package org.w3c.dom
{	
	public interface ILocation
	{	
		function get href():String
		function get protocol():String
		function get host():String
		function get hostname():String
		function get port():String
		function get pathname():String
		function get search():String
		function get hash():String
		
		function assign(url:String):void
		function replace(url:String):void
		function reload():void
	}
}