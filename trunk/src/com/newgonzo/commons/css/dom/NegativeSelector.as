package com.newgonzo.commons.css.dom
{
	import com.newgonzo.commons.css.sac.INegativeSelector;
	import com.newgonzo.commons.css.sac.ISimpleSelector;
	import com.newgonzo.commons.css.sac.SelectorTypes;
	
	public class NegativeSelector implements IExtendedSelector, INegativeSelector
	{
		private var selectorArgument:IExtendedSelector;
		
		public function NegativeSelector(selector:ISimpleSelector)
		{
			selectorArgument = selector as IExtendedSelector;
		}
		
		public function get simpleSelector():ISimpleSelector
		{
			return selectorArgument;
		}
		
		public function select(xml:XML):XMLList
		{
			var matches:XMLList = selectorArgument.select(xml);
			var newList:XMLList = new XMLList();
			var match:XML;
			var test:XML;
			var matched:Boolean;
			
			for each(test in xml)
			{
				trace("test " + test.toXMLString());
				
				matched = false;
				
				for each(match in matches)
				{
					trace("tst contains " + match.toXMLString() + ": " + test.contains(match));
					
					if(test.contains(match))
					{
						matched = true;
						break;
					}
				}				
				
				// wasn't matched
				if(!matched)
				{
					newList += test;
				}
			}
			
			return newList;
		}
		
		public function get type():int
		{
			return SelectorTypes.SAC_NEGATIVE_SELECTOR;
		}
	}
}