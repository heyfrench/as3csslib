package com.newgonzo.web.css.views
{
	public interface ICSSView
	{
		function get ignoreCase():Boolean
		function set ignoreCase(value:Boolean):void
		
		function localName(node:*):String
		function namespaceURI(node:*):String
		
		function lang(node:*):String
		function cssId(node:*):String
		function cssClass(node:*):String
		function childIndex(node:*):int
		function parent(node:*):*
		function numChildren(node:*):int
		function child(node:*, index:int):*
		function textContent(node:*):String
		
		function isPseudoClass(node:*, pseudoClass:String):Boolean
		function isType(node:*, localName:String):Boolean
		
		function attributes(node:*, localName:String, namespaceURI:String = null):Array
		
		// for calculating relative values
		//function blockWidth(node:*):Number
		//function blockHeight(node:*):Number
	}
}