package com.newgonzo.web.css.rules
{
	import com.newgonzo.web.css.ICSSSerializable;
	
	import org.w3c.css.sac.CSSError;
	import org.w3c.css.sac.CSSErrorTypes;
	import org.w3c.dom.css.CSSRuleTypes;
	import org.w3c.dom.css.ICSSMediaRule;
	import org.w3c.dom.css.ICSSRuleList;
	import org.w3c.dom.css.ICSSStyleSheet;
	import org.w3c.dom.stylesheets.IMediaList;

	public class MediaRule extends CSSRule implements ICSSMediaRule
	{
		protected var mediaList:IMediaList;
		protected var rules:ICSSRuleList;
		
		public function MediaRule(parentStyleSheet:ICSSStyleSheet, media:IMediaList, cssRules:ICSSRuleList = null)
		{
			super(parentStyleSheet);
			
			mediaList = media;
			rules = cssRules ? cssRules : new CSSRuleList();
		}
		
		override public function get type():uint
		{
			return CSSRuleTypes.MEDIA_RULE;
		}
		
		override public function get cssText():String
		{
			var len:int = rules.length;
			
			//if(len == 0) return "";
			
			if(!mediaList.length)
			{
				return "";
			}
			
			var output:String = "@media " + (mediaList as ICSSSerializable).toCSSString() + " {\n\n";
			
			if(len > 0)
			{
				output += (rules[0] as ICSSSerializable).toCSSString();
				
				var i:int = 1;
				while(i < len)
				{
					output += "\n\n" + rules[i].toCSSString();
					i++;
				}
			}
			
			return output + "\n\n}";
		}
		
		public function get media():IMediaList
		{
			return mediaList;
		}
		
		public function get cssRules():ICSSRuleList
		{
			return rules;
		}
		
		public function insertRule(rule:String, index:int=int.MAX_VALUE):int
		{
			throw new CSSError("insertRule is not supported", CSSErrorTypes.SAC_NOT_SUPPORTED_ERR);
		}
		
		public function deleteRule(index:int):void
		{
			(rules as Array).splice(index, 1);
		}
		
	}
}