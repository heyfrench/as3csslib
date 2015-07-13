package com.newgonzo.web.css.views
{
	import flash.errors.IllegalOperationError;
	import flash.utils.getQualifiedClassName;

	public class ObjectCSSView extends AbstractCSSView implements ICSSView
	{
		private var propMap:Object =
		{
				localName: null,
				lang: null,
				cssId: "id",
				cssClass: "cssClass",
				childIndex: null,
				parent: "parent",
				numChildren: "numChildren",
				textContent: "textContent",
				child: null
		}
		
		public function ObjectCSSView(media:*=null, propertyMap:Object=null)
		{
			super(media);
			
			if(propertyMap)
			{
				var prop:String;
				
				for(prop in propertyMap)
				{
					propMap[prop] = propertyMap[prop];
				}
			}
		}
		
		public function namespaceURI(node:*):String
		{
			return getQualifiedClassName(node).match(/^([^:]+):/)[1];
		}
		
		override public function localName(node:*):String
		{
			return cleanClassName(getQualifiedClassName(node));
		}

		public function lang(node:*):String
		{
			return getStringValue(node, propMap.lang);
		}

		public function cssId(node:*):String
		{
			return getStringValue(node, propMap.cssId);
		}
		
		public function cssClass(node:*):String
		{
			return getStringValue(node, propMap.cssClass);
		}
		
		public function childIndex(node:*):int
		{
			return parseInt(getValue(node, propMap.childIndex));
		}
		
		public function parent(node:*):*
		{
			return getValue(node, propMap.parent);
		}
		
		public function numChildren(node:*):int
		{
			return parseInt(getValue(node, propMap.numChildren));
		}
		
		public function child(node:*, index:int):*
		{
			throw new IllegalOperationError("ObjectCSSView.child() must be overridden.");
		}
		
		override public function attributes(node:*, localName:String, namespaceURI:String=null):Array
		{
			// TODO: Fix Me
			return [getStringValue(node, localName)];
		}
		
		public function textContent(node:*):String
		{
			return getStringValue(node, propMap.textContent);
		}
		
		protected function cleanClassName(className:String):String
		{
			return className.match(/:?([^:]+)$/)[1];
		}
		
		protected function getValue(node:*, propName:String):*
		{
			if(node.hasOwnProperty(propName) && node[propName] != null)
			{
				return node[propName];
			}
			
			return null;
		}
		
		protected function getStringValue(node:*, propName:String):String
		{
			var value:* = getValue(node, propName);
			
			if(value !== null)
			{
				return value.toString();
			}
			
			return "";
		}
	}
}