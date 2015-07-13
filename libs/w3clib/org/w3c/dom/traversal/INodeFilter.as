package org.w3c.dom.traversal
{
	import org.w3c.dom.INode;
	
	public interface INodeFilter
	{
		function acceptNode(node:INode):uint
	}
}