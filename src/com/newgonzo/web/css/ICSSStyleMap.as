package com.newgonzo.web.css
{
	import org.w3c.dom.css.ICSSValue;
	
	public interface ICSSStyleMap
	{
		function get styleNames():Array
		
		function hasProperty(propName:String):Boolean
		function getProperty(propName:String):ICSSValue
		function setProperty(propName:String, value:ICSSValue, priority:String = null):void
		function removeProperty(propName:String):ICSSValue
		
		function getPropertyPriority(propName:String):String
		function setPropertyPriority(propName:String, priority:String):void
		function toCSSString():String
	}
}