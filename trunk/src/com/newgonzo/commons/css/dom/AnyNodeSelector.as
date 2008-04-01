package com.newgonzo.commons.css.dom
{
	import com.newgonzo.commons.css.sac.IElementSelector;
	import com.newgonzo.commons.css.sac.SelectorTypes;
	
	public class AnyNodeSelector implements IExtendedSelector
	{
		
		public function AnyNodeSelector()
		{

		}
		
		public function select(xml:XML):XMLList
		{
			var newList:XMLList = new XMLList(xml);
			
			// should this include text nodes?
			newList += xml.descendants().(nodeKind() != "text");
			return newList;
		}
		
		public function match(node:XML):Boolean
		{
			// every node matches 
			return node != null;
		}
		
		public function get type():int
		{
			return SelectorTypes.SAC_ANY_NODE_SELECTOR;
		}
	}
}