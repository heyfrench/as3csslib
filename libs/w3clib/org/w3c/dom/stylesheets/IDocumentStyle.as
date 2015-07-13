package org.w3c.dom.stylesheets
{	
	import org.w3c.dom.IDocument;
	
	public interface IDocumentStyle extends IDocument
	{
		function get styleSheets():IStyleSheetList
	}
}