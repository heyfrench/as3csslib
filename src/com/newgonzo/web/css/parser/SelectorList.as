package com.newgonzo.web.css.parser
{
	import org.w3c.css.sac.ISelector;
	import org.w3c.css.sac.ISelectorList;	

	dynamic public class SelectorList extends Array implements ISelectorList
	{
		public function SelectorList()
		{
			super();
		}
		
		public function append(selector:ISelector):void
		{
			push(selector);
		}
		
		public function item(index:int):ISelector
		{
			return this[index] as ISelector;
		}
		
		public function toString():String
		{
			return join(",");
		}
	}
}