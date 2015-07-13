package org.w3c.dom.traversal
{
	import org.w3c.dom.INode;
	
	public interface ITreeWalker
	{
		function get rootNode():INode
		function get currentNode():INode
		function set currentNode(value:INode):void
		function get filter():INodeFilter
		function parentNode():INode
		function firstChild():INode
		function lastChild():INode
		function nextSibling():INode
		function previousSibling():INode
		function nextNode():INode
		function previousNode():INode
	}
}