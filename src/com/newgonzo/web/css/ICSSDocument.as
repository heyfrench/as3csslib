package com.newgonzo.web.css
{
	import org.w3c.dom.css.ICSSStyleSheet;
	
	public interface ICSSDocument extends ICSSSerializable
	{
		function get context():ICSSContext

		function get origin():int
		function set origin(value:int):void
		
		function set uri(value:String):void
		function get uri():String
		
		function get styleSheet():ICSSStyleSheet
		function set styleSheet(value:ICSSStyleSheet):void
		
		function get warnings():Array // array of ICSSParseError
		function get errors():Array // array of ICSSParseError
		
		function parseCSS(css:String):void
		function resolveURI(uri:String):String
		
		// support for @namespace
		function registerNamespace(prefix:String, uri:String):void
		function lookupNamespacePrefix(uri:String):String
		function lookupNamespaceURI(prefix:String = null):String
	}
}