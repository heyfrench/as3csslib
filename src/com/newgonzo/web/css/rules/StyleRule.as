package com.newgonzo.web.css.rules
{
	import com.newgonzo.web.css.selectors.IExtendedSelector;
	
	import org.w3c.css.sac.CSSError;
	import org.w3c.css.sac.CSSErrorTypes;
	import org.w3c.css.sac.ISelectorList;
	import org.w3c.dom.css.CSSRuleTypes;
	import org.w3c.dom.css.ICSSStyleDeclaration;
	import org.w3c.dom.css.ICSSStyleSheet;	

	public class StyleRule extends CSSRule implements IStyleRule
	{
		private var cssSelectors:ISelectorList;
		private var declaration:ICSSStyleDeclaration;
		
		public function StyleRule(parentStyleSheet:ICSSStyleSheet, selectors:ISelectorList, style:ICSSStyleDeclaration)
		{
			super(parentStyleSheet);
			
			cssSelectors = selectors;
			declaration = style;
		}
		
		override public function get type():uint
		{
			return CSSRuleTypes.STYLE_RULE;
		}
		
		public function get selectors():ISelectorList
		{
			return cssSelectors;
		}
		
		public function get style():ICSSStyleDeclaration
		{
			return declaration;
		}
		
		override public function get cssText():String
		{
			var output:String = selectorText + " { \n";
			output += declaration.cssText + "}";
			
			return output;
		}
		
		public function get selectorText():String
		{
			var len:int = cssSelectors.length;
			
			if(len == 0) return "";
			
			var s:String = (cssSelectors.item(0) as IExtendedSelector).toCSSString(document);
			var idx:int = 1;
			
			while(idx < len)
			{
				s += ", " + (cssSelectors.item(idx) as IExtendedSelector).toCSSString(document);
				idx++;
			}
			
			return s;
		}
		
		public function set selectorText(value:String):void
		{
			throw new CSSError("selectorText setter is not supported", CSSErrorTypes.SAC_NOT_SUPPORTED_ERR);
		}
	}
}
