
package com.newgonzo.commons.css.sac
{
	public interface IConditionFactory 
	{
		function createAndCondition(first:ICondition, second:ICondition):ICombinatorCondition
		function createOrCondition(first:ICondition, second:ICondition):ICombinatorCondition
		function createNegativeCondition(condition:ICondition):INegativeCondition
		function createPositionalCondition(position:int, typeNode:Boolean, type:Boolean):IPositionalCondition
		function createAttributeCondition(localName:String, namespaceURI:String, specified:Boolean, value:String):IAttributeCondition
		function createIdCondition(value:String):IAttributeCondition
		function createLangCondition(lang:String):ILangCondition
		function createOneOfAttributeCondition(localName:String, namespaceURI:String, specified:Boolean, value:String):IAttributeCondition
		function createBeginHyphenAttributeCondition(localName:String, namespaceURI:String, specified:Boolean, value:String):IAttributeCondition
		function createPrefixAttributeCondition(localName:String, namespaceURI:String, specified:Boolean, value:String):IAttributeCondition
		function createSuffixAttributeCondition(localName:String, namespaceURI:String, specified:Boolean, value:String):IAttributeCondition
		function createSubstringAttributeCondition(localName:String, namespaceURI:String, specified:Boolean, value:String):IAttributeCondition
		function createClassCondition(namespaceURI:String, value:String):IAttributeCondition
		function createPseudoClassCondition(namespaceURI:String, value:String):IAttributeCondition
		function createOnlyChildCondition():ICondition
		function createOnlyTypeCondition():ICondition
		function createContentCondition(data:String):IContentCondition
	}
}
