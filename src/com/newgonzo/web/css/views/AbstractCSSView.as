package com.newgonzo.web.css.views
{
	import flash.utils.getQualifiedClassName;
	
	public class AbstractCSSView
	{
		private var viewMedia:*;
		private var caseIgnored:Boolean = false;
		
		public function AbstractCSSView(media:* = null)
		{
			viewMedia = media;
		}
		
		public function supportsMedia(media:*):Boolean
		{
			if(!media) return true;
			return media.indexOf("all") != -1 || media.indexOf(viewMedia) != -1;
		}
		
		public function set ignoreCase(value:Boolean):void
		{
			caseIgnored = value;
		}
		public function get ignoreCase():Boolean
		{
			return caseIgnored;
		}
		
		public function localName(node:*):String
		{
			return null;
		}
		
		public function isType(node:*, localName:String):Boolean
		{
			return this.localName(node) == localName;	
		}
		
		public function isPseudoClass(node:*, pseudoClass:String):Boolean
		{
			return false;
		}
		
		public function attributes(node:*, localName:String, namespaceURI:String = null):Array
		{
			return null;
		}
		
		protected function attribute(node:*, localName:String, namespaceURI:String=null):String
		{
			var atts:Array = attributes(node, localName, namespaceURI);
			
			if(atts && atts.length)
			{
				return atts[0] as String;
			}
			
			return null;
		}
	}
}