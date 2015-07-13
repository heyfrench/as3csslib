package org.w3c.dom.css
{
	import org.w3c.dom.stylesheets.IMediaList;
	
	public interface ICSSImportRule extends ICSSRule
	{
		function get href():String
		function get media():IMediaList
		function get styleSheet():ICSSStyleSheet
	}
}