package com.newgonzo.commons.css.dom
{
	import com.newgonzo.commons.css.sac.ISelector;
	import com.newgonzo.commons.css.sac.ISelectorList;
	
	public class SelectorList implements ISelectorList
	{
		private var selectors:Array;
		
		public function SelectorList()
		{
			selectors = new Array();
		}
		
		public function append(selector:ISelector):void
		{
			selectors.push(selector);
		}
		
		public function get length():int
		{
			return selectors.length;
		}
		
		public function item(index:int):ISelector
		{
			return selectors[index] as ISelector;
		}
	}
}