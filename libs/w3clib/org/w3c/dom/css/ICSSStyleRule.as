package org.w3c.dom.css
{
	public interface ICSSStyleRule extends ICSSRule
	{
		function get selectorText():String
		function set selectorText(value:String):void
		function get style():ICSSStyleDeclaration
	}
}
