
package org.w3c.css.sac
{
	public interface ISelectorFactory 
	{
		function createConditionalSelector(selector:ISimpleSelector, condition:ICondition):IConditionalSelector
		function createAnyNodeSelector(namespaceURI:String):ISimpleSelector
		function createRootNodeSelector():ISimpleSelector
		function createNegativeSelector(selector:ISimpleSelector):INegativeSelector
		function createElementSelector(namespaceURI:String, tagName:String):IElementSelector
		function createTextNodeSelector(data:String):ICharacterDataSelector
		function createCDataSectionSelector(data:String):ICharacterDataSelector
		function createProcessingInstructionSelector(target:String, data:String):IProcessingInstructionSelector
		function createCommentSelector(data:String):ICharacterDataSelector
		function createPseudoElementSelector(namespaceURI:String, pseudoName:String):IElementSelector
		function createDescendantSelector(parent:ISelector, descendant:ISimpleSelector):IDescendantSelector
		function createChildSelector(parent:ISelector, child:ISimpleSelector):IDescendantSelector
		function createDirectAdjacentSelector(nodeType:int, child:ISelector, directAdjacent:ISimpleSelector):ISiblingSelector
		function createGeneralSiblingSelector(nodeType:int, child:ISelector, sibling:ISimpleSelector):ISiblingSelector
	}
}
