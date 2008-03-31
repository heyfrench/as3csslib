package com.newgonzo.commons.css.sac
{
	public interface IDocumentHandler
	{
		function startDocument(source:String):void
		function endDocument(source:String):void
		function comment(text:String):void
		
		function startSelector(selectors:ISelectorList):void
		function endSelector(selectors:ISelectorList):void
		
		//function ignorableAtRule(atRule:String):void
		//function namespaceDeclaration(prefix:String, uri:String):void 
		//function importStyle(uri:String, media:IMediaList, defaultNamespaceURI:String):void
		//function startMedia(media:IMediaList):void
		//function endMedia(media:IMediaList):void
		//function startPage(name:String, pseudoPage:String):void
		//function endPage(name:String, pseudoPage:String):void
		//function startFontFace():void
		//function endFontFace():void
		function property(name:String, value:Object, important:Boolean):void
	}
}
