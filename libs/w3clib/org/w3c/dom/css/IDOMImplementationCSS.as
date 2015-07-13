package org.w3c.dom.css
{	
	import org.w3c.dom.IDOMImplementation;
	
	public interface IDOMImplementationCSS extends IDOMImplementation
	{
		function createCSSStyleSheet(media:String = ""):ICSSStyleSheet
	}
}