package com.newgonzo.commons.css.dom
{
	import com.newgonzo.commons.css.sac.IDescendantSelector;
	import com.newgonzo.commons.css.sac.ISimpleSelector;
	import com.newgonzo.commons.css.sac.ISelector;
	import com.newgonzo.commons.css.sac.SelectorTypes;
	
	public class ChildSelector extends DescendantSelector
	{
		public function ChildSelector(parent:ISelector, child:ISimpleSelector)
		{
			super(parent, child);
		}
		
		override public function select(xml:XML):XMLList
		{
			// get nodes that match rightmost selector
			var children:XMLList = selector.select(xml);
			
			// get nodes that match leftmost selector
			var parents:XMLList = ancestor.select(xml);
			
			var child:XML;
			var potentialParent:XML;
			var newList:XMLList = new XMLList();
			
			for each(child in children)
			{	
				for each(potentialParent in parents)
				{
					if(potentialParent === child.parent())
					{
						// parent matches, don't need to check other potentials
						newList += child;
						
						// next child
						break;
					}
				}
						
			}
			
			return newList;
		}
		
		override public function get type():int
		{
			return SelectorTypes.SAC_CHILD_SELECTOR;
		}
	}
}