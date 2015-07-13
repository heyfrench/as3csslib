package com.newgonzo.web.css
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	// this is to stop FlexBuilder from removing the import above
	flash_proxy;	

	import org.w3c.dom.css.ICSSRule;
	import org.w3c.dom.css.ICSSStyleDeclaration;
	import org.w3c.dom.css.ICSSValue;
	import com.newgonzo.web.css.properties.utils.PropertyNameUtil;
	import org.w3c.css.sac.CSSError;
	import org.w3c.css.sac.CSSErrorTypes;	

	dynamic public class CSSStyleDeclaration extends Proxy implements ICSSStyleDeclaration, ICSSDocumentNode
	{
		protected var styleMap:ICSSStyleMap;
		protected var rule:ICSSRule;
		protected var cssDocument:ICSSDocument;
		
		public function CSSStyleDeclaration(cssStyleMap:ICSSStyleMap, parentRule:ICSSRule = null)
		{
			styleMap = cssStyleMap;
			rule = parentRule;
			
			if(parentRule is ICSSDocumentNode)
			{
				cssDocument = (parentRule as ICSSDocumentNode).document;
			}
		}
		
		public function get parent():ICSSDocumentNode
		{
			return parentRule as ICSSDocumentNode;
		}
		
		public function get document():ICSSDocument
		{
			return cssDocument;
		}
		public function set document(value:ICSSDocument):void
		{
			cssDocument = value;
		}
		
		public function get length():uint
		{
			return styleMap.styleNames.length;
		}
		
		public function item(idx:uint):String
		{
			return styleMap.styleNames[idx] as String;
		}
		
		public function get parentRule():ICSSRule
		{
			return rule;
		}
		
		public function get cssText():String
		{
			return toCSSString();
		}
		
		public function set cssText(value:String):void
		{
			// TODO:
			throw new CSSError("cssText setter is not supported", CSSErrorTypes.SAC_NOT_SUPPORTED_ERR);
		}
		
		public function getPropertyCSSValue(name:String):ICSSValue
		{
			return styleMap.getProperty(name);
		}
		
		public function removeProperty(name:String):String
		{
			return styleMap.removeProperty(name).cssText;
		}
		
		public function setProperty(name:String, value:String, priority:String = ""):void
		{
			// TODO:
			throw new CSSError("setProperty is not supported", CSSErrorTypes.SAC_NOT_SUPPORTED_ERR);
		}
		
		public function getPropertyValue(propertyName:String):String
		{
			return styleMap.hasProperty(propertyName) ?  styleMap.getProperty(propertyName).cssText : "";
		}
		
		public function getPropertyPriority(name:String):String
		{
			return styleMap.getPropertyPriority(name);
		}
		
		public function toCSSString():String
		{
			return styleMap.toCSSString();
		}
		
		public function toString():String
		{
			return toCSSString();
		}
		
		protected function getPropertyValueInternal(propertyName:String):*
		{
			return getPropertyValue(propertyName);
		}
		
		/* 
		Proxy implementation
		*/
		flash_proxy override function hasProperty(name:*):Boolean
		{
			try
			{
				// if property requested is already camel case, nothing will happen here
				var cssProp:String = PropertyNameUtil.fromCamelCase((name as QName).localName);
				
				return styleMap.hasProperty(cssProp);
			}
			catch(e:Error)
			{
				//trace(e.getStackTrace());
			}
			
			return false;
		}
		
		flash_proxy override function getProperty(name:*):*
		{
			try
			{
				// if property requested is already camel case, nothing will happen here
				var cssProp:String = PropertyNameUtil.fromCamelCase((name as QName).localName);
				
				return getPropertyValueInternal(cssProp);
			}
			catch(e:Error)
			{
				//trace(e.getStackTrace());
			}
		}
		
		flash_proxy override function nextName(index:int):String
		{
			try
			{
				return PropertyNameUtil.toCamelCase(styleMap.styleNames[index - 1]);
			}
			catch(e:Error)
			{
				//trace(e.getStackTrace());
			}
			
			return null;
		}
		
		flash_proxy override function nextNameIndex(index:int):int
		{
			try
			{
				var len:int = styleMap.styleNames.length;
				
				return index < len ? (index + 1) : 0;
			}
			catch(e:Error)
			{
				//trace(e.getStackTrace());
			}
			
			return 0;
		}
		 
		flash_proxy override function nextValue(index:int):*
		{
			try
			{
				return getPropertyValueInternal(styleMap.styleNames[index - 1]);
			}
			catch(e:Error)
			{
				//trace(e.getStackTrace());
			}
			
			return null;
		}
		
		flash_proxy override function callProperty(name:*, ...rest):*
		{
			return null;
		}
	}
}
