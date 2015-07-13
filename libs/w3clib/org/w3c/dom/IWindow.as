package org.w3c.dom
{	
	public interface IWindow
	{
		function get name():String
		function get window():IWindow
		function get self():IWindow
		function get parent():IWindow
		function get top():IWindow
		function get opener():IWindow
		
		function get history():IHistory
		function get location():ILocation
		
		function alert(message:String):void
		function confirm(message:String):void
		function prompt(message:String, defaultMessage:String = ""):void
		function open(url:String, target:String = "", features:String = ""):IWindow
	}
}