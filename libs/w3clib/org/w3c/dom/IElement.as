package org.w3c.dom
{	
	public interface IElement extends INode
	{
		function get tagName():String
		function getElementsByTagName(tagName:String):Array
		function hasAttribute(name:String):Boolean
		function getAttribute(name:String):String
		function setAttribute(name:String, value:String):void
	}
}