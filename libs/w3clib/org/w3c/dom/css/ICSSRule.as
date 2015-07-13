package org.w3c.dom.css
{
	public interface ICSSRule
	{
		function get type():uint
		function get cssText():String
		function set cssText(value:String):void
		function get parentRule():ICSSRule
		function get parentStyleSheet():ICSSStyleSheet
	}
}