package org.w3c.dom.xpath
{	
	import org.w3c.dom.INode;
	
	public interface IXPathExpression
	{
		function evaluate(context:INode):IXPathResult
	}
}