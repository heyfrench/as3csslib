package org.w3c.dom.css
{
	public interface ICSSPageRule extends ICSSRule
	{
		function get selectorText():String
		function set selectorText(value:String):void
		function get style():ICSSStyleDeclaration
	}
}