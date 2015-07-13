package com.newgonzo.web.css
{
	import com.newgonzo.web.css.parser.ICSSParser;
	import com.newgonzo.commons.utils.URIUtil;
	
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;
	
	import org.w3c.css.sac.IDocumentHandler;
	import org.w3c.css.sac.IErrorHandler;
	import org.w3c.dom.css.*;

	public class CSSDocument implements ICSSDocument
	{
		public static const DEFAULT_NS_PREFIX:String = "default";
		public static const DEFAULT_MEDIA:String = CSSMediaType.DEFAULT;
		
		protected var cssContext:ICSSContext;
		
		private var docOrigin:int;
		private var docUri:String;
		
		private var parseErrors:Array;
		private var parseWarnings:Array;

		private var cssStyleSheet:ICSSStyleSheet;
		private var nsUriPrefixes:Dictionary;
		private var nsPrefixUris:Dictionary;
		
		public function CSSDocument(context:ICSSContext, documentURI:String = null, documentOrigin:int = -1)
		{
			cssContext = context;
			docUri = documentURI;
			docOrigin = documentOrigin ? documentOrigin : CSSDocumentOrigin.USER_AGENT;
			
			nsUriPrefixes = new Dictionary();
			nsPrefixUris = new Dictionary();
		}
		
		public function get context():ICSSContext
		{
			return cssContext;
		}
		
		public function get origin():int
		{
			return docOrigin;
		}
		public function set origin(value:int):void
		{
			docOrigin = value;
		}
		
		public function set uri(value:String):void
		{
			docUri = value;
		}
		public function get uri():String
		{
			return docUri;
		}
		
		public function get styleSheet():ICSSStyleSheet
		{
			return cssStyleSheet;
		}
		public function set styleSheet(value:ICSSStyleSheet):void
		{
			cssStyleSheet = value;
		}
		
		public function get warnings():Array
		{
			return parseWarnings;
		}
		
		public function get errors():Array
		{
			return parseErrors;
		}
		
		public function resolveURI(uri:String):String
		{
			return URIUtil.getAbsolute(uri, docUri);
		}
		
		public function lookupNamespacePrefix(uri:String):String
		{
			var prefix:String = nsUriPrefixes[uri];
			return prefix == DEFAULT_NS_PREFIX ? null : prefix;
		}
		
		public function lookupNamespaceURI(prefix:String = null):String
		{
			return nsPrefixUris[prefix ? prefix : DEFAULT_NS_PREFIX];
		}
		
		public function registerNamespace(prefix:String, uri:String):void
		{
			nsPrefixUris[prefix ? prefix : DEFAULT_NS_PREFIX] = uri;
			nsUriPrefixes[uri] = prefix;
		}
		
		public function parseCSS(css:String):void
		{
			parseErrors = new Array();
			parseWarnings = new Array();
			
			var parser:ICSSParser = cssContext.factory.createParser();
			var docHandler:IDocumentHandler = cssContext.factory.createDocumentHandler(this);
			var errorHandler:IErrorHandler = cssContext.factory.createErrorHandler(this);
			
			parser.documentHandler = docHandler;
			parser.errorHandler = errorHandler;
			parser.parseStyleSheet(css);
		}
		
		public function toCSSString():String
		{
			return (styleSheet as ICSSSerializable).toCSSString();
		}
		
		public function toString():String
		{
			return toCSSString();
		}
	}
}
