package com.newgonzo.commons.css.dom
{
	import com.newgonzo.commons.css.sac.ISiblingSelector;
	import com.newgonzo.commons.css.sac.ISimpleSelector;
	import com.newgonzo.commons.css.sac.ISelector;
	import com.newgonzo.commons.css.sac.SelectorTypes;
	
	public class SiblingSelector extends AbstractSiblingSelector implements IExtendedSelector, ISiblingSelector
	{
		public function SiblingSelector(nodeType:int, child:ISelector, sibling:ISimpleSelector)
		{
			super(nodeType, child, sibling);
		}
		
		public function select(xml:XML):XMLList
		{
			// get nodes that match leftmost selector
			var siblings:XMLList = simpleSelector.select(xml);
		
			var children:XMLList = childSelector.select(xml);
			
			var sibling:XML;
			var potentialSibling:XML;
			var newList:XMLList = new XMLList();
			
			for each(sibling in siblings)
			{				
				for each(potentialSibling in children)
				{
					if(potentialSibling.parent() === sibling.parent() && potentialSibling.childIndex() < sibling.childIndex())
					{
						// this is an ancestor, don't need to check other potentials
						newList += sibling;
						
						// next child
						break;
					}
				}
						
			}
			
			return newList;
		}

		public function get type():int
		{
			return SelectorTypes.SAC_GENERAL_SIBLING_SELECTOR;
		}
	}
}