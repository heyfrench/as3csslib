package com.newgonzo.web.css.rules
{
	import com.newgonzo.web.css.ICSSSerializable;
	
	import org.w3c.dom.css.ICSSRule;
	import org.w3c.dom.css.ICSSRuleList;	

	dynamic public class CSSRuleList extends Array implements ICSSRuleList
	{	
		public function CSSRuleList()
		{
			super();
		}
		
		public function item(index:int):ICSSRule
		{
			if(index < 0 || index > length - 1) return null;
			
			return this[index] as ICSSRule;
		}
		
		public function toCSSString():String
		{
			if(length == 0) return "";
			
			var s:String = (this[0] as ICSSSerializable).toCSSString();
			var i:int = 1;
			
			while(i < length)
			{
				s += (this[i] as ICSSSerializable).toCSSString();
			}
			
			return s;
		}
		
		public function toString():String
		{
			return "[CSSRuleList(length=" + length + ")]";
		}
	}
}
