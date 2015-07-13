package org.w3c.dom.css
{
	import org.w3c.dom.IElement;
	import org.w3c.dom.css.ICSSStyleDeclaration;
	import org.w3c.dom.stylesheets.IDocumentStyle;
	
	public interface IDocumentCSS extends IDocumentStyle
	{
		function getOverrideStyle(element:IElement, pseudoElement:String = ""):ICSSStyleDeclaration;
	}
}