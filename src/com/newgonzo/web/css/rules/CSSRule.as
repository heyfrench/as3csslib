package com.newgonzo.web.css.rules
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.ICSSDocumentNode;
	
	import org.w3c.css.sac.CSSError;
	import org.w3c.css.sac.CSSErrorTypes;
	import org.w3c.dom.css.CSSRuleTypes;
	import org.w3c.dom.css.ICSSRule;
	import org.w3c.dom.css.ICSSStyleSheet;	

	public class CSSRule implements ICSSRule, ICSSDocumentNode
	{
		protected var parentSheet:ICSSStyleSheet;
		protected var parentCSSRule:ICSSRule;
		protected var cssDocument:ICSSDocument;
		
		public function CSSRule(parentStyleSheet:ICSSStyleSheet)
		{
			parentSheet = parentStyleSheet;
			
			if(parentStyleSheet is ICSSDocumentNode)
			{
				cssDocument = (parentStyleSheet as ICSSDocumentNode).document;
			}
		}
		
		public function get document():ICSSDocument
		{
			return cssDocument;
		}
		public function set document(value:ICSSDocument):void
		{
			cssDocument = value;
		}
		
		public function get type():uint
		{
			return CSSRuleTypes.UNKNOWN_RULE;
		}
		
		public function get parentStyleSheet():ICSSStyleSheet
		{
			return parentSheet;
		}
		
		public function get parentRule():ICSSRule
		{
			return parentCSSRule;
		}
		
		public function set parentRule(value:ICSSRule):void
		{
			parentCSSRule = value;
		}
		
		public function get cssText():String
		{
			return "";
		}
		
		public function set cssText(value:String):void
		{
			throw new CSSError("cssText is read-only", CSSErrorTypes.SAC_NOT_SUPPORTED_ERR);
		}
		
		public function toCSSString():String
		{
			return cssText;
		}
		
		public function toString():String
		{
			return toCSSString();
		}
	}
}
