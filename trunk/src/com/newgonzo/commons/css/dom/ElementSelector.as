package com.newgonzo.commons.css.dom
{
	import com.newgonzo.commons.css.sac.IElementSelector;
	import com.newgonzo.commons.css.sac.SelectorTypes;
	
	public class ElementSelector implements IExtendedSelector, IElementSelector
	{
		private var ns:String;
		private var tag:String;
		
		public function ElementSelector(namespaceURI:String, tagName:String)
		{
			ns = namespaceURI;
			tag = tagName;
		}
		
		public function get namespaceURI():String
		{
			return ns;
		}
		
		public function get localName():String
		{
			return tag;
		}
		
		public function select(xml:XML):XMLList
		{
			var newList:XMLList = new XMLList();
			var test:String = tag.toLowerCase();
			
			// case insensitive
			if(xml.localName() && xml.localName().toString().toLowerCase() == test)
			{
				newList += xml;
			}
			
			newList += xml.descendants().(localName() && localName().toString().toLowerCase() == test);
			return newList;
		}
		
		public function get type():int
		{
			return SelectorTypes.SAC_ELEMENT_NODE_SELECTOR;
		}
	}
}