package com.newgonzo.commons.net
{
	public class MIME
	{
		public static const APPLICATION_RSS_XML:String = "application/rss+xml";
		public static const APPLICATION_ATOM_XML:String = "application/atom+xml";
		public static const APPLICATION_XHTML_XML:String = "application/xhtml+xml";
	
		public static const TEXT_PLAIN:String = "text/plain";
		public static const TEXT_XML:String = "text/xml";
		public static const TEXT_CSS:String = "text/css";
		public static const TEXT_JAVASCRIPT:String = "text/javascript";
		public static const TEXT_HTML:String = "text/html";
		
		// "enumerations"
		public static const XML_TYPES:Array = new Array(APPLICATION_RSS_XML, APPLICATION_ATOM_XML, APPLICATION_XHTML_XML, TEXT_XML);
		public static const FEED_TYPES:Array = new Array(APPLICATION_RSS_XML, APPLICATION_ATOM_XML);
		
		public static function isXml(type:String):Boolean
		{
			return XML_TYPES.indexOf(type) != -1;
		}
	}
}