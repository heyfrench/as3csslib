
package com.newgonzo.commons.css.dom
{
	import com.newgonzo.commons.css.sac.*;
	
	public class SelectorFactory implements ISelectorFactory
	{
		public function createConditionalSelector(selector:ISimpleSelector, condition:ICondition):IConditionalSelector
		{
			trace("SelectorFactory.createConditionalSelector(" + arguments + ")");
			return new ConditionalSelector(selector, condition);	
		}
		
		public function createAnyNodeSelector():ISimpleSelector
		{
			trace("SelectorFactory.createAnyNodeSelector(" + arguments + ")");
			return new AnyNodeSelector();
		}

		public function createRootNodeSelector():ISimpleSelector
		{
			trace("SelectorFactory.createRootNodeSelector(" + arguments + ")");
			return null;
		}

		public function createNegativeSelector(selector:ISimpleSelector):INegativeSelector
		{
			trace("SelectorFactory.createNegativeSelector(" + arguments + ")");
			return new NegativeSelector(selector);
		}

		public function createElementSelector(namespaceURI:String, tagName:String):IElementSelector
		{
			trace("SelectorFactory.createElementSelector(" + arguments + ")");
			return new ElementSelector(namespaceURI, tagName);
		}

		public function createTextNodeSelector(data:String):ICharacterDataSelector
		{
			trace("SelectorFactory.createTextNodeSelector(" + arguments + ")");
			return null;
		}

		public function createCDataSectionSelector(data:String):ICharacterDataSelector
		{
			trace("SelectorFactory.createCDataSectionSelector(" + arguments + ")");
			return null;
		}

		public function createProcessingInstructionSelector(target:String, data:String):IProcessingInstructionSelector
		{
			trace("SelectorFactory.createProcessingInstructionSelector(" + arguments + ")");
			return null;
		}

		public function createCommentSelector(data:String):ICharacterDataSelector
		{
			trace("SelectorFactory.createCommentSelector(" + arguments + ")");
			return null;
		}

		public function createPseudoElementSelector(namespaceURI:String, pseudoName:String):IElementSelector
		{
			trace("SelectorFactory.createPseudoElementSelector(" + arguments + ")");
			return null;
		}

		public function createDescendantSelector(parent:ISelector, descendant:ISimpleSelector):IDescendantSelector
		{
			trace("SelectorFactory.createDescendantSelector(" + arguments + ")");
			return new DescendantSelector(parent, descendant);
		}

		public function createChildSelector(parent:ISelector, child:ISimpleSelector):IDescendantSelector
		{
			trace("SelectorFactory.createChildSelector(" + arguments + ")");
			return new ChildSelector(parent, child);
		}

		public function createDirectAdjacentSelector(nodeType:int, child:ISelector, directAdjacent:ISimpleSelector):ISiblingSelector
		{
			trace("SelectorFactory.createDirectAdjacentSelector(" + arguments + ")");
			return new DirectAdjacentSelector(nodeType, child, directAdjacent);
		}

		public function createGeneralSiblingSelector(nodeType:int, child:ISelector, sibling:ISimpleSelector):ISiblingSelector
		{
			trace("SelectorFactory.createGeneralSiblingSelector(" + arguments + ")");
			return new SiblingSelector(nodeType, child, sibling);
		}
	}
}
