package com.newgonzo.web.css
{
	import com.newgonzo.web.css.rules.IStyleRule;
	import com.newgonzo.web.css.views.ICSSView;
	
	public interface ICSSStyleSelector
	{
		// the unsorted array of ICSSDocuments
		function get documents():Array
		function set documents(value:Array):void
		
		// the sorted array of ICSSDocuments by origin
		function get cascade():Array
		
		function addDocument(document:ICSSDocument):ICSSDocument
		function removeDocument(document:ICSSDocument):ICSSDocument
		
		function getComputedStyle(cssView:ICSSView, node:*, pseudoElement:String = null):CSSComputedStyle
		function getMatchingRules(cssView:ICSSView, node:*, pseudoElement:String = null):Array
	}
}