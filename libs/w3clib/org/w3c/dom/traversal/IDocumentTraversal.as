package org.w3c.dom.traversal
{
	import org.w3c.dom.INode;
	
	public interface IDocumentTraversal
	{
		function createTreeWalker(rootNode:INode, whatToShow:int = 0, filter:INodeFilter = null):ITreeWalker
	}
}