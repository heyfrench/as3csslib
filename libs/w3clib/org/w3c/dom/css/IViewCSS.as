package org.w3c.dom.css
{
	import org.w3c.dom.views.IAbstractView;
	import org.w3c.dom.IElement;
	
	public interface IViewCSS extends IAbstractView
	{
		function getComputedStyle(element:IElement, pseudoElement:String = ""):ICSSStyleDeclaration
	}
}