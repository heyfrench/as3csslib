package com.newgonzo.web.css.selectors
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.views.ICSSView;
	
	import org.w3c.css.sac.ConditionTypes;
	import org.w3c.css.sac.ILangCondition;	

	public class LangCondition implements IExtendedCondition, ILangCondition
	{
		private var language:String;
		
		public function LangCondition(lang:String)
		{
			language = lang;
		}
		
		public function get specificity():uint
		{
			return 1 << 8;
		}
		
		public function get lang():String
		{
			return language;
		}
		
		public function match(view:ICSSView, node:*):Boolean
		{
			// From http://www.w3.org/TR/css3-selectors/#lang-pseudo
			// :lang(C)
    		// The pseudo-class :lang(C) represents an element that is in language C.
    		// Whether an element is represented by a :lang() selector is based solely on the
    		// element's language value (normalized to BCP 47 syntax if necessary) being equal to
    		// the identifier C, or beginning with the identifier C immediately followed by "-" (U+002D).
    		// The matching of C against the element's language value is performed case-insensitively. 
    		// The identifier C does not have to be a valid language name.
			var nodeLang:String = view.lang(node);
			
			if(nodeLang == language || nodeLang.indexOf(language + "-") == 0)
			{
				return true;
			}
			
			return false;
		}
		
		public function get conditionType():int
		{
			return ConditionTypes.SAC_LANG_CONDITION;
		}
		
		public function toCSSString(document:ICSSDocument):String
		{
			return ":lang(" + language + ")";
		}
	}
}