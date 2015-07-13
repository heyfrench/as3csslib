package org.w3c.css.sac
{
	public interface IDocumentHandler
	{
		function startDocument(source:String):void
		function endDocument(source:String):void
		function comment(text:String):void
		
		function startSelector(selectors:ISelectorList):void
		function endSelector(selectors:ISelectorList):void
		
		function importStyle(uri:String, media:ISACMediaList, defaultNamespaceURI:String):void
		function startMedia(media:ISACMediaList):void
		function endMedia(media:ISACMediaList):void
		function ignorableAtRule(atRule:String):void
		
		function namespaceDeclaration(prefix:String, uri:String):void
		function property(name:String, value:ILexicalUnit, important:Boolean):void
		
		//function startFontFace():void
		//function endFontFace():void
		//function startPage(name:String, pseudoPage:String):void
		//function endPage(name:String, pseudoPage:String):void
	}
}
