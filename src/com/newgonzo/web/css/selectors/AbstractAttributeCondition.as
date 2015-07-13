package com.newgonzo.web.css.selectors
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.views.ICSSView;
		
	public class AbstractAttributeCondition
	{
		private var ns:String;
		private var attributeName:String;
		private var isSpecified:Boolean;
		private var attributeValue:String;
		
		public function AbstractAttributeCondition(localName:String, namespaceURI:String, specified:Boolean, value:String)
		{
			attributeName = localName;
			ns = namespaceURI;
			isSpecified = specified;
			attributeValue = value;
		}
		
		public function get specificity():uint
		{
			return 1 << 8;
		}
		
		public function get namespaceURI():String
		{
			return ns;
		}
		
		public function get localName():String
		{
			return attributeName;
		}
		
		public function get specified():Boolean
		{
			return isSpecified;
		}
		
		public function get value():String
		{
			return attributeValue;
		}
		
		public function match(view:ICSSView, node:*):Boolean
		{
			var attrs:Array = view.attributes(node, attributeName, ns);
			
			if(isSpecified)
			{
				var attr:String;
				
				for each(attr in attrs)
				{
					if(matchValue(attr))
					{
						return true;
					}
				}
				
				return false;
			}
			else
			{				
				return attrs && attrs.length > 0;
			}
		}
		
		protected function matchValue(value:String):Boolean
		{
			return false;
		}
		
		protected function formatToString(document:ICSSDocument, condition:String):String
		{
			var defaultNS:String = document.lookupNamespaceURI();
			var prefix:String;
			
			if(ns == "")
			{
				prefix = "";
			}
			else if(ns == "*")
			{
				prefix = defaultNS ? "*" : null;
			}
			else
			{
				prefix = document.lookupNamespacePrefix(ns);
			}
			
			return "[" + (prefix != null ? prefix + "|" : "") + attributeName + (isSpecified ? condition + "\"" + attributeValue + "\"" : "") + "]";
		}
	}
}