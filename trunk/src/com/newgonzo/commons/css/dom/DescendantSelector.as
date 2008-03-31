package com.newgonzo.commons.css.dom
{
	import com.newgonzo.commons.css.sac.IDescendantSelector;
	import com.newgonzo.commons.css.sac.ISimpleSelector;
	import com.newgonzo.commons.css.sac.ISelector;
	import com.newgonzo.commons.css.sac.SelectorTypes;
	
	public class DescendantSelector implements IExtendedSelector, IDescendantSelector
	{
		protected var ancestor:IExtendedSelector;
		protected var selector:IExtendedSelector;
		
		public function DescendantSelector(parent:ISelector, descendant:ISimpleSelector)
		{
			ancestor = parent as IExtendedSelector;
			selector = descendant as IExtendedSelector;
		}
		
		public function get ancestorSelector():ISelector
		{
			return ancestor;
		}
		
		public function get simpleSelector():ISimpleSelector
		{
			return selector;
		}
		
		public function select(xml:XML):XMLList
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
					if(isAncestorOf(potentialParent, child))
					{
						// this is an ancestor, don't need to check other potentials
						newList += child;
						
						// next child
						break;
					}
				}
						
			}
			
			return newList;
		}
		
		public function isAncestorOf(element:XML, child:XML):Boolean
		{
			var p:XML = child;
			
			while(p)
			{
				if(p === element)
				{
					return true;
				}
				
				p = p.parent();
			}
			
			return false;
		}

		
		public function get type():int
		{
			return SelectorTypes.SAC_DESCENDANT_SELECTOR;
		}
	}
}