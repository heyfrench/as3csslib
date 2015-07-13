package com.newgonzo.web.css
{
	import com.newgonzo.web.css.rules.CSSRuleList;
	
	import org.w3c.css.sac.CSSError;
	import org.w3c.css.sac.CSSErrorTypes;
	import org.w3c.dom.INode;
	import org.w3c.dom.css.ICSSRule;
	import org.w3c.dom.css.ICSSRuleList;
	import org.w3c.dom.css.ICSSStyleSheet;
	import org.w3c.dom.stylesheets.IMediaList;
	import org.w3c.dom.stylesheets.IStyleSheet;	

	public class CSSStyleSheet implements ICSSStyleSheet, ICSSDocumentNode
	{
		protected var cssDocument:ICSSDocument;
		protected var rules:ICSSRuleList;
		protected var owner:ICSSRule;
		
		protected var sheetHref:String;
		protected var sheetType:String;
		protected var sheetTitle:String;
		protected var mediaList:IMediaList;
		protected var node:INode;
		protected var isDisabled:Boolean = false;
		
		public function CSSStyleSheet(document:ICSSDocument = null, media:IMediaList = null, ownerRule:ICSSRule = null, cssRules:ICSSRuleList = null)
		{
			mediaList = media;
			cssDocument = document;
			owner = ownerRule;
			rules = cssRules ? cssRules : new CSSRuleList();
		}
		
		public function get parentStyleSheet():IStyleSheet
		{
			return null;
		}
		
		public function set media(value:IMediaList):void
		{
			mediaList = value;
		}
		public function get media():IMediaList
		{
			return mediaList;
		}
		
		public function set ownerNode(value:INode):void
		{
			node = value;
		}
		public function get ownerNode():INode
		{
			return node;
		}
		
		public function set disabled(value:Boolean):void
		{
			isDisabled = value;
		}
		public function get disabled():Boolean
		{
			return isDisabled;
		}
		
		public function set href(value:String):void
		{
			sheetHref = value;
		}
		public function get href():String
		{
			return sheetHref;
		}
		
		public function set title(value:String):void
		{
			sheetTitle = value;
		}
		public function get title():String
		{
			return sheetTitle;
		}
		
		public function set type(value:String):void
		{
			sheetType = value;
		}
		public function get type():String
		{
			return sheetType;
		}
		
		public function get document():ICSSDocument
		{
			return cssDocument;
		}
		public function set document(value:ICSSDocument):void
		{
			cssDocument = value;
		}
		
		public function get cssRules():ICSSRuleList
		{
			return rules;
		}
		
		public function get ownerRule():ICSSRule
		{
			return owner;
		}
		
		public function get cssText():String
		{
			return toCSSString();
		}
		
		public function insertRule(rule:String, index:uint):void
		{
			throw new CSSError("insertRule is not supported", CSSErrorTypes.SAC_NOT_SUPPORTED_ERR);
		}
		
		public function deleteRule(index:uint):void
		{
			(rules as Array).splice(index, 1);
		}
		
		public function toCSSString():String
		{
			var len:int = rules.length;
			if(len == 0) return "";
			
			var output:String = rules[0].toCSSString();
			var i:int = 1;
			
			while(i < len)
			{
				output += "\n\n" + rules[i].toCSSString();
				i++;
			}
			
			if(mediaList && mediaList.length)
			{
				var medias:String = (mediaList as ICSSSerializable).toCSSString();
				output = "@media " + medias + " {\n\n" + output + "\n\n}";
			}
			
			return output;
		}
	}
}
