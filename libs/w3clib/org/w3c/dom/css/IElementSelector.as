package org.w3c.dom.css
{
	import org.w3c.dom.IElement;
	
	public interface IElementSelector
	{
		function querySelector(selector:String):IElement
		function querySelectorAll(selector:String):Array
	}
}