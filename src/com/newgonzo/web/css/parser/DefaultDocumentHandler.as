package com.newgonzo.web.css.parser
{
	import org.w3c.css.sac.IDocumentHandler;
	import org.w3c.css.sac.ILexicalUnit;
	import org.w3c.css.sac.ISACMediaList;
	import org.w3c.css.sac.ISelectorList;	

	public class DefaultDocumentHandler implements IDocumentHandler
	{
		public static const INSTANCE:DefaultDocumentHandler = new DefaultDocumentHandler();
		
		
		public function startDocument(source:String):void
		{
		}
		
		public function endDocument(source:String):void
		{
		}
		
		public function comment(text:String):void
		{
		}
		
		public function startSelector(selectors:ISelectorList):void
		{
		}
		
		public function endSelector(selectors:ISelectorList):void
		{
		}
		
		public function importStyle(uri:String, media:ISACMediaList, defaultNamespaceURI:String):void
		{
		}
		
		public function startMedia(media:ISACMediaList):void
		{
		}
		
		public function endMedia(media:ISACMediaList):void
		{
		}
		
		public function namespaceDeclaration(prefix:String, uri:String):void
		{
		}
		
		public function ignorableAtRule(atRule:String):void
		{
		}
		
		public function property(name:String, value:ILexicalUnit, important:Boolean):void
		{
		}
	}
}
