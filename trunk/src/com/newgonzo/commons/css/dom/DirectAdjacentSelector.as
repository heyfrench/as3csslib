package com.newgonzo.commons.css.dom
{
	import com.newgonzo.commons.css.sac.ISiblingSelector;
	import com.newgonzo.commons.css.sac.ISimpleSelector;
	import com.newgonzo.commons.css.sac.ISelector;
	import com.newgonzo.commons.css.sac.SelectorTypes;
	
	public class DirectAdjacentSelector implements IExtendedSelector, ISiblingSelector
	{
		// Element, Comment, CDATA?
		private var xmlType:int;
		private var childSelector:IExtendedSelector;
		private var adjacentSelector:IExtendedSelector;
		
		public function DirectAdjacentSelector(nodeType:int, child:ISelector, directAdjacent:ISimpleSelector)
		{
			xmlType = nodeType;
			childSelector = child as IExtendedSelector;
			adjacentSelector = directAdjacent as IExtendedSelector;
		}
		
		public function get nodeType():int
		{
			return xmlType;
		}
		
		public function get selector():ISelector
		{
			return childSelector;
		}
		
		public function get siblingSelector():ISimpleSelector
		{
			return adjacentSelector;
		}
		
		public function select(xml:XML):XMLList
		{
			// get nodes that match leftmost selector
			var adjacents:XMLList = adjacentSelector.select(xml);
		
			var children:XMLList = childSelector.select(xml);
			
			var adjacent:XML;
			var potentialSibling:XML;
			var newList:XMLList = new XMLList();
			
			for each(adjacent in adjacents)
			{					
				for each(potentialSibling in children)
				{
					if(potentialSibling.parent() === adjacent.parent() && potentialSibling.childIndex() == adjacent.childIndex() - 1)
					{
						// this is an ancestor, don't need to check other potentials
						newList += adjacent;
						
						// next child
						break;
					}
				}
						
			}
			
			return newList;
		}

		public function get type():int
		{
			return SelectorTypes.SAC_DIRECT_ADJACENT_SELECTOR;
		}
	}
}