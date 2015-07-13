package org.w3c.dom
{
	import flash.events.IEventDispatcher;
	
	public interface INode extends IEventDispatcher
	{
		function get nodeName():String
		function get localName():String
		
		function get nodeType():uint
		
		function get nodeValue():String
		function set nodeValue(value:String):void
		
		function get namespaceURI():String
		function get prefix():String
		
		function get ownerDocument():IDocument
		
		function get firstChild():INode
		function get lastChild():INode
		function get nextSibling():INode
		function get previousSibling():INode
		function get parentNode():INode
		function get childNodes():Array
		
		function get hasChildNodes():Boolean
		function get hasAttributes():Boolean
		
		function get textContent():String
		
		function compareDocumentPosition(node:INode):uint
		function isSameNode(node:INode):Boolean
		function isEqualNode(node:INode):Boolean
	}
}