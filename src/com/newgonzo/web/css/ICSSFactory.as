package com.newgonzo.web.css
{
	import com.newgonzo.web.css.net.IRequestHandler;
	import com.newgonzo.web.css.parser.ICSSParser;
	import com.newgonzo.web.css.rules.IStyleRule;
	
	import flash.net.URLRequest;
	
	import org.w3c.css.sac.IDocumentHandler;
	import org.w3c.css.sac.IErrorHandler;
	import org.w3c.css.sac.ILexicalUnit;
	import org.w3c.css.sac.ISACMediaList;
	import org.w3c.css.sac.ISelectorList;
	import org.w3c.css.sac.helpers.IParserFactory;
	import org.w3c.dom.css.ICSSMediaRule;
	import org.w3c.dom.css.ICSSNamespaceRule;
	import org.w3c.dom.css.ICSSRule;
	import org.w3c.dom.css.ICSSRuleList;
	import org.w3c.dom.css.ICSSStyleDeclaration;
	import org.w3c.dom.css.ICSSStyleSheet;
	import org.w3c.dom.css.ICSSValue;
	import org.w3c.dom.stylesheets.IMediaList;
	
	public interface ICSSFactory extends IParserFactory
	{
		function createParser():ICSSParser
		function createDocument(context:ICSSContext, uri:String = null, origin:int = -1):ICSSDocument
		function createDocumentHandler(document:ICSSDocument):IDocumentHandler
		function createErrorHandler(document:ICSSDocument):IErrorHandler
		
		function createMediaQuery(media:*):CSSMediaQuery
		function createStyleSheet(document:ICSSDocument = null, media:IMediaList = null, ownerRule:ICSSRule = null, cssRules:ICSSRuleList = null):ICSSStyleSheet
		function createNamespaceRule(parentStyleSheet:ICSSStyleSheet, prefix:String, namespaceURI:String):ICSSNamespaceRule
		function createStyleRule(parentStyleSheet:ICSSStyleSheet, selectors:ISelectorList, style:ICSSStyleDeclaration):IStyleRule
		function createImportRule(parentStyleSheet:ICSSStyleSheet, uri:String, media:ISACMediaList):ICSSRule
		function createMediaRule(parentStyleSheet:ICSSStyleSheet, media:IMediaList, cssRules:ICSSRuleList = null):ICSSMediaRule
		function createStyleDeclaration(styleMap:ICSSStyleMap, parentRule:ICSSRule = null):ICSSStyleDeclaration
		function createStyleMap():ICSSStyleMap
		function createValue(unit:ILexicalUnit):ICSSValue
		
		function createRequestHandler(url:URLRequest):IRequestHandler
	}
}