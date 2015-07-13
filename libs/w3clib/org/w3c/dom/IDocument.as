package org.w3c.dom
{	
	public interface IDocument extends INode
	{
		//function get doctype():IDocumentType
		
		
		function get implementation():IDOMImplementation
		function get documentElement():IElement
		function set documentURI(value:String):void
		function get documentURI():String
		function getElementsByTagName(tagName:String):Array
		function getElementById(id:String):IElement
		function createElement(tagName:String):IElement
		function createTextNode(data:String):IText
	}
}