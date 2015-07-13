package com.newgonzo.web.css.views
{
	public class XMLCSSView extends AbstractCSSView implements ICSSView
	{
		public function XMLCSSView(media:*=null)
		{
			super(media);
		}
		
		public function namespaceURI(node:*):String
		{
			var ns:* = node.namespace();
			return ns ? ns.uri : null;
		}

		override public function localName(node:*):String
		{
			var ln:* = node.localName();
			return ln ? ln.toString() : null;
		}
		
		public function lang(node:*):String
		{
			return attribute(node, "lang");
		}
		
		public function cssId(node:*):String
		{
			return attribute(node, "id");
		}
		
		public function cssClass(node:*):String
		{
			return attribute(node, "class");
		}
		
		public function childIndex(node:*):int
		{
			return node.childIndex();
		}
		
		public function parent(node:*):*
		{
			return node.parent();
		}
		
		public function numChildren(node:*):int
		{
			return node.children().(nodeKind() == "element").length();
		}
		
		public function child(node:*, index:int):*
		{
			return node.children().(nodeKind() == "element")[index];
		}
		
		override public function attributes(node:*, localName:String, namespaceURI:String=null):Array
		{
			// TODO: This needs some major workarounds to work properly b/c of
			// Flash's namespace bugs
			var attributes:XMLList = node.attributes();
			var attribute:XML;
			
			var matchAny:Boolean = namespaceURI == null;
			var matchNone:Boolean = namespaceURI != null && namespaceURI.length == 0;
			
			var attributeName:String;
			var attributeNS:String;
			var matches:Array = new Array();
			
			for each(attribute in attributes)
			{
				attributeName = String(attribute.localName());

				if(attributeName != localName) continue;
				
				attributeNS = String(attribute.namespace());
				
				if(matchAny || (matchNone && (!attributeNS || !attributeNS.length)) || namespaceURI == attributeNS)
				{
					matches.push(String(attribute));
				}
			}
			
			return matches;
		}
		
		public function textContent(node:*):String
		{
			return node.text();
		}
	}
}