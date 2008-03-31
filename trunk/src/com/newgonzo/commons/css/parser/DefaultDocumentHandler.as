package com.newgonzo.commons.css.parser
{
	import com.newgonzo.commons.css.sac.IDocumentHandler;
	import com.newgonzo.commons.css.sac.ISelectorList;
	
	public class DefaultDocumentHandler implements IDocumentHandler
	{
		public function startDocument(source:String):void
		{
			trace("DefaultDocumentHandler.startDocument()");
		}
		
		public function endDocument(source:String):void
		{
			trace("DefaultDocumentHandler.endDocument()");
		}
		
		public function comment(text:String):void
		{
			trace("DefaultDocumentHandler.comment(" + text + ")");	
		}
		
		public function startSelector(selectors:ISelectorList):void
		{
			trace("DefaultDocumentHandler.startSelector(" + selectors + ")");
		}
		
		public function endSelector(selectors:ISelectorList):void
		{
			trace("DefaultDocumentHandler.endSelector(" + selectors + ")");
		}
		
		//public function ignorableAtRule(atRule:String):void
		//public function namespaceDeclaration(prefix:String, uri:String):void 
		//public function importStyle(uri:String, media:IMediaList, defaultNamespaceURI:String):void
		//public function startMedia(media:IMediaList):void
		//public function endMedia(media:IMediaList):void
		//public function startPage(name:String, pseudoPage:String):void
		//public function endPage(name:String, pseudoPage:String):void
		//public function startFontFace():void
		//public function endFontFace():void
		public function property(name:String, value:Object, important:Boolean):void
		{
			trace("DefaultDocumentHandler.property(" + arguments + ")");
		}
	}
}
