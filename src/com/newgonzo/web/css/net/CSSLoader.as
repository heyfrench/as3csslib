package com.newgonzo.web.css.net
{
	import com.newgonzo.web.css.CSS;
	import com.newgonzo.web.css.ICSSDocument;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import org.w3c.css.sac.CSSError;
	import org.w3c.dom.css.CSSRuleTypes;
	import org.w3c.dom.css.ICSSImportRule;
	import org.w3c.dom.css.ICSSRule;
	import org.w3c.dom.css.ICSSRuleList;
	import org.w3c.dom.css.ICSSStyleSheet;

	public class CSSLoader extends EventDispatcher
	{
		protected var handlersToImports:Dictionary;
		protected var waitingImports:Array;
		
		protected var sourceCss:CSS;
		
		public function CSSLoader(source:CSS)
		{
			sourceCss = source;
		
			handlersToImports = new Dictionary();
			waitingImports = new Array();
			processImports();
		}
		
		public function get css():CSS
		{
			return sourceCss;
		}
		
		protected function processImports():void
		{
			var documents:Array = sourceCss.selector.cascade;
			var document:ICSSDocument;
			
			for each(document in documents)
			{
				loadDocumentImports(document);
			}
		}
		
		protected function loadDocumentImports(document:ICSSDocument):void
		{
			var styleSheet:ICSSStyleSheet = document.styleSheet;
			var rules:ICSSRuleList = styleSheet.cssRules;
			var rule:ICSSRule;
				
			for each(rule in rules)
			{
				if(rule.type == CSSRuleTypes.IMPORT_RULE)
				{
					loadImport(rule as ICSSImportRule);
				}
			}
		}
		
		protected function loadImport(importRule:ICSSImportRule):void
		{
			var url:String = importRule.href;
			var handler:IRequestHandler = sourceCss.context.factory.createRequestHandler(new URLRequest(url));
			
			handlersToImports[handler] = importRule;
			waitingImports.push(importRule);
			
			handler.load(handleImportComplete, handleImportError);
		}
		
		protected function handleImportComplete(handler:IRequestHandler):void
		{
			var importRule:ICSSImportRule = handlersToImports[handler] as ICSSImportRule;
			
			// TODO: Make sure the URL being thrown around here is properly resolved
			var loadedDocument:ICSSDocument = sourceCss.context.factory.createDocument(sourceCss.context, importRule.href, -1);
			
			// TODO: Make sure this is the best way to do this
			loadedDocument.styleSheet = importRule.styleSheet;
			
			// parse
			loadedDocument.parseCSS(handler.data);
			
			// cleanup after this import and see if there are
			// any still waiting to be loaded
			delete handlersToImports[handler];
			waitingImports.splice(waitingImports.indexOf(importRule), 1);
			
			// load imports in loaded document
			loadDocumentImports(loadedDocument);
			
			if(!waitingImports.length)
			{
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		protected function handleImportError(handler:IRequestHandler):void
		{
			trace("error: " + handler.error);
		}
	}
}