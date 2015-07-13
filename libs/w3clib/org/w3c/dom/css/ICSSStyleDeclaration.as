package org.w3c.dom.css
{
	public interface ICSSStyleDeclaration
	{
		function set cssText(value:String):void
		function get cssText():String
		
		function getPropertyValue(name:String):String
		function getPropertyCSSValue(name:String):ICSSValue
		function getPropertyPriority(name:String):String
		function setProperty(name:String, value:String, priority:String = ""):void
		function removeProperty(name:String):String
		
		function get length():uint // number of properties
		function item(idx:uint):String // property name
		
		function get parentRule():ICSSRule
	}
}
