package com.newgonzo.web.css.rules
{
	import org.w3c.dom.css.ICSSNamespaceRule;
	import org.w3c.dom.css.ICSSStyleSheet;

	public class NamespaceRule extends CSSRule implements ICSSNamespaceRule
	{
		private var nsPrefix:String;
		private var nsUri:String;
		
		public function NamespaceRule(parentStyleSheet:ICSSStyleSheet, prefix:String, namespaceURI:String)
		{
			super(parentStyleSheet);
			
			nsPrefix = prefix;
			nsUri = namespaceURI;
		}
		
		public function get prefix():String
		{
			return nsPrefix;
		}
		
		public function get namespaceURI():String
		{
			return nsUri;
		}
		
		override public function toCSSString():String
		{
			if(nsPrefix)
			{
				return "@namespace " + nsPrefix + " \"" + nsUri + "\";";
			}
			else
			{
				return "@namespace \"" + nsUri + "\";";
			}
		}
	}
}