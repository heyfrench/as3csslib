package org.w3c.dom.html
{
	import org.w3c.dom.IDocument;
	
	public interface IHTMLDocument extends IDocument
	{
		function set title(value:String):void
		function get title():String
		//function get referrer():String
		//function get domain():String
		function get body():IHTMLElement
		function get images():Array
		function get anchors():Array
		function get links():Array
		function get forms():Array
		function get applets():Array
		function getElementsByName(elementName:String):Array
	}
}
