package com.newgonzo.commons.css
{
	import com.newgonzo.commons.css.dom.IExtendedSelector;
	
	import com.newgonzo.commons.css.sac.ISelectorList;
	import com.newgonzo.commons.css.parser.CSSParser;
	
	
	public class CSSSelectorQuery
	{
		private var parser:CSSParser;
		private var selectors:ISelectorList;
		
		public function CSSSelectorQuery(selectorSource:*)
		{	
			if(selectorSource is ISelectorList)
			{
				selectors = selectorSource as ISelectorList;
			}
			else
			{
				parser = new CSSParser();
				selectors = (new CSSParser).parseSelectors(selectorSource as String);
			}
		}
		
		public static function execQuery(selectorSource:*, target:XML):XMLList
		{			
			return (new CSSSelectorQuery(selectorSource)).exec(target);
		}
		
		public function exec(target:XML):XMLList
		{
			var newList:XMLList = new XMLList();
			var selector:IExtendedSelector;
			
			var len:int = selectors.length;
			
			for(var i:int = 0; i < len; i++)
			{
				selector = selectors.item(i) as IExtendedSelector;				
				newList += selector.select(target);
			}
			
			return newList;
		}
	}
}