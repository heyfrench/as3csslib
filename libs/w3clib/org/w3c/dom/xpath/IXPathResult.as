package org.w3c.dom.xpath
{	
	import org.w3c.dom.INode;
	
	public interface IXPathResult
	{
		function get type():uint
		function get numberValue():Number
		function get stringValue():String
		function get booleanValue():Boolean
		function get singleNodeValue():INode
		function get invalidIteratorState():Boolean
		function get snapshotLength():uint
		function iterateNext():INode
		function snapshotItem(index:uint):INode
	}
}