package com.newgonzo.web.css.views
{
	import org.w3c.dom.IElement;

	public class ElementCSSView extends AbstractCSSView implements ICSSView
	{
		public function ElementCSSView(media:*=null)
		{
			super(media);
		}
		
		public function namespaceURI(node:*):String
		{
			return node.namespaceURI;
		}

		override public function localName(node:*):String
		{
			return node.localName;
		}
		
		public function lang(node:*):String
		{
			return node.getAttribute("lang");
		}
		
		public function cssId(node:*):String
		{
			return node.getAttribute("id");
		}
		
		public function cssClass(node:*):String
		{
			return node.getAttribute("class");
		}
		
		public function childIndex(node:*):int
		{
			return node.parentNode ? node.parentNode.childNodes.indexOf(node) : -1;
		}
		
		public function parent(node:*):*
		{
			return node.parentNode is IElement ? node.parentNode : null;
		}
		
		public function numChildren(node:*):int
		{
			return node.childNodes.length;
		}
		
		public function child(node:*, index:int):*
		{
			return node.childNodes[index];
		}
		
		override public function attributes(node:*, localName:String, namespaceURI:String = null):Array
		{
			// TODO: Fix me
			return [node.getAttribute(localName)];
		}
		
		public function textContent(node:*):String
		{
			return node.textContent;
		}
	}
}