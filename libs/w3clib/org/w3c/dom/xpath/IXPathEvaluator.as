package org.w3c.dom.xpath
{	
	import org.w3c.dom.INode;
	
	public interface IXPathEvaluator
	{
		function createExpression():IXPathExpression
		function evaluate(expr:String, context:INode):IXPathResult
	}
}