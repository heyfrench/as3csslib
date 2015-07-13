package com.newgonzo.web.css
{
	import com.newgonzo.web.css.parser.LexicalUnitStream;
	import com.newgonzo.web.css.properties.CSSPriority;
	import com.newgonzo.web.css.properties.IPropertyManager;
	
	import org.w3c.css.sac.IDocumentHandler;
	import org.w3c.css.sac.ILexicalUnit;
	import org.w3c.css.sac.ISACMediaList;
	import org.w3c.css.sac.ISelectorList;
	import org.w3c.dom.css.ICSSMediaRule;
	import org.w3c.dom.css.ICSSRule;
	import org.w3c.dom.css.ICSSRuleList;
	import org.w3c.dom.css.ICSSStyleDeclaration;
	import org.w3c.dom.css.ICSSStyleSheet;
	import org.w3c.dom.stylesheets.IMediaList;

	public class CSSDocumentHandler implements IDocumentHandler
	{
		protected var document:ICSSDocument;
		protected var currentSheet:ICSSStyleSheet;
		protected var currentRule:ICSSRule;
		protected var currentMediaRule:ICSSMediaRule;
		
		protected var currentStyle:ICSSStyleDeclaration;
		protected var currentStyleMap:ICSSStyleMap;
		
		protected var currentRuleList:ICSSRuleList;
		
		public function CSSDocumentHandler(cssDocument:ICSSDocument)
		{	
			document = cssDocument;
			currentSheet = document.styleSheet;
		}
		
		public function startDocument(source:String):void
		{
			if(!currentSheet)
			{
				currentSheet = document.context.factory.createStyleSheet(document);
			}
			
			currentRuleList = currentSheet.cssRules;
		}
		
		public function startSelector(selectors:ISelectorList):void
		{
			currentStyleMap = document.context.factory.createStyleMap();
			
			var style:ICSSStyleDeclaration = document.context.factory.createStyleDeclaration(currentStyleMap, currentRule);
			currentRule = document.context.factory.createStyleRule(currentSheet, selectors, style);
		}
		
		public function endSelector(selectors:ISelectorList):void
		{
			(currentRuleList as Array).push(currentRule);
			currentRule = null;
		}
		
		public function importStyle(uri:String, mediaList:ISACMediaList, defaultNamespaceURI:String):void
		{
			(currentSheet.cssRules as Array).push(document.context.factory.createImportRule(currentSheet, uri, mediaList));
		}
		
		public function startMedia(media:ISACMediaList):void
		{
			currentMediaRule = document.context.factory.createMediaRule(currentSheet, (media as IMediaList));
			currentRuleList = currentMediaRule.cssRules;
		}
		
		public function endMedia(media:ISACMediaList):void
		{
			(currentSheet.cssRules as Array).push(currentMediaRule);
			currentMediaRule = null;
			currentRuleList = currentSheet.cssRules;
		}
		
		public function ignorableAtRule(atRule:String):void
		{
			
		}
		
		public function namespaceDeclaration(prefix:String, uri:String):void
		{
			document.registerNamespace(prefix, uri);
			
			// add the namespace object to the CSS OM
			(currentSheet.cssRules as Array).push(document.context.factory.createNamespaceRule(currentSheet, prefix, uri));
		}
		
		public function property(propName:String, value:ILexicalUnit, important:Boolean):void
		{
			//trace("CSSDocumentHandler.property(" + arguments + ")");
			var priority:String = important ? CSSPriority.IMPORTANT : "";
			var stream:LexicalUnitStream = new LexicalUnitStream(value);
			var propManager:IPropertyManager = document.context.getPropertyManager(propName);
			
			propManager.setValues(document, currentStyleMap, stream, priority);
		}
		
		public function endDocument(source:String):void
		{
			document.styleSheet = currentSheet;
			
			currentSheet = null;
			currentRule = null;
			currentMediaRule = null;
			currentRuleList = null;
			currentStyleMap = null;
		}
		
		public function comment(text:String):void
		{
		}
	}
}
