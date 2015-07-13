package org.w3c.dom.html
{
	import org.w3c.dom.IElement;
	
	public interface IHTMLElement extends IElement
	{
		function get id():String
		function get title():String
		function get lang():String
		function get dir():String
		function get className():String
	}
}
