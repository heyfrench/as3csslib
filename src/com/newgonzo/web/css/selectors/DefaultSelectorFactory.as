
package com.newgonzo.web.css.selectors
{
	import org.w3c.css.sac.*;			

	public class DefaultSelectorFactory implements IExtendedSelectorFactory
	{
		public static const INSTANCE:DefaultSelectorFactory = new DefaultSelectorFactory();
		
		public function createConditionalSelector(selector:ISimpleSelector, condition:ICondition):IConditionalSelector
		{
			return new ConditionalSelector(selector, condition);	
		}
		
		public function createAnyNodeSelector(namespaceURI:String):ISimpleSelector
		{
			return new AnyNodeSelector(namespaceURI);
		}

		public function createRootNodeSelector():ISimpleSelector
		{
			return null;
		}

		public function createNegativeSelector(selector:ISimpleSelector):INegativeSelector
		{
			return null;//new NegativeSelector(selector);
		}

		public function createElementSelector(namespaceURI:String, tagName:String):IElementSelector
		{
			return new ElementSelector(namespaceURI, tagName);
		}

		public function createDescendantSelector(parent:ISelector, descendant:ISimpleSelector):IDescendantSelector
		{
			return new DescendantSelector(parent, descendant);
		}

		public function createChildSelector(parent:ISelector, child:ISimpleSelector):IDescendantSelector
		{
			return new ChildSelector(parent, child);
		}

		public function createDirectAdjacentSelector(nodeType:int, child:ISelector, directAdjacent:ISimpleSelector):ISiblingSelector
		{
			return new DirectAdjacentSelector(nodeType, child, directAdjacent);
		}

		public function createGeneralSiblingSelector(nodeType:int, child:ISelector, sibling:ISimpleSelector):ISiblingSelector
		{
			return new SiblingSelector(nodeType, child, sibling);
		}
		
		public function createTextNodeSelector(data:String):ICharacterDataSelector
		{
			return null;
		}

		public function createCDataSectionSelector(data:String):ICharacterDataSelector
		{
			return null;
		}

		public function createProcessingInstructionSelector(target:String, data:String):IProcessingInstructionSelector
		{
			return null;
		}

		public function createCommentSelector(data:String):ICharacterDataSelector
		{
			return null;
		}

		public function createPseudoElementSelector(namespaceURI:String, pseudoName:String):IElementSelector
		{
			return null;
		}
	}
}
