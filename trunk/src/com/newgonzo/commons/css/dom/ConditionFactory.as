
package com.newgonzo.commons.css.dom
{
	import com.newgonzo.commons.css.sac.*;
	
	public class ConditionFactory implements IConditionFactory
	{
		public function createAndCondition(first:ICondition, second:ICondition):ICombinatorCondition
		{
			trace("ConditionFactory.createAndCondition(" + arguments + ")");
			return new AndCondition(first, second);
		}

		public function createOrCondition(first:ICondition, second:ICondition):ICombinatorCondition
		{
			trace("ConditionFactory.createOrCondition(" + arguments + ")");
			return null;
		}

		public function createNegativeCondition(condition:ICondition):INegativeCondition
		{
			trace("ConditionFactory.createNegativeCondition(" + arguments + ")");
			return null;
		}

		public function createPositionalCondition(position:int, typeNode:Boolean, type:Boolean):IPositionalCondition
		{
			trace("ConditionFactory.createPositionalCondition(" + arguments + ")");
			return null;
		}

		public function createAttributeCondition(localName:String, namespaceURI:String, specified:Boolean, value:String):IAttributeCondition
		{
			trace("ConditionFactory.createAttributeCondition(" + arguments + ")");
			return new AttributeCondition(localName, namespaceURI, specified, value);
		}

		public function createIdCondition(value:String):IAttributeCondition
		{
			trace("ConditionFactory.createIdCondition(" + arguments + ")");
			return new IdCondition(value);
		}

		public function createLangCondition(lang:String):ILangCondition
		{
			trace("ConditionFactory.createLangCondition(" + arguments + ")");
			return new LangCondition(lang);
		}

		public function createOneOfAttributeCondition(localName:String, namespaceURI:String, specified:Boolean, value:String):IAttributeCondition
		{
			trace("ConditionFactory.createOneOfAttributeCondition(" + arguments + ")");
			return new OneOfAttributeCondition(localName, namespaceURI, specified, value);
		}

		public function createBeginHyphenAttributeCondition(localName:String, namespaceURI:String, specified:Boolean, value:String):IAttributeCondition
		{
			trace("ConditionFactory.createBeginHyphenAttributeCondition(" + arguments + ")");
			return new HyphenAttributeCondition(localName, namespaceURI, specified, value);
		}

		public function createPrefixAttributeCondition(localName:String, namespaceURI:String, specified:Boolean, value:String):IAttributeCondition
		{
			trace("ConditionFactory.createPrefixAttributeCondition(" + arguments + ")");
			return new PrefixAttributeCondition(localName, namespaceURI, specified, value);
		}

		public function createSuffixAttributeCondition(localName:String, namespaceURI:String, specified:Boolean, value:String):IAttributeCondition
		{
			trace("ConditionFactory.createSuffixAttributeCondition(" + arguments + ")");
			return new SuffixAttributeCondition(localName, namespaceURI, specified, value);
		}

		public function createSubstringAttributeCondition(localName:String, namespaceURI:String, specified:Boolean, value:String):IAttributeCondition
		{
			trace("ConditionFactory.createSubstringAttributeCondition(" + arguments + ")");
			return new SubstringAttributeCondition(localName, namespaceURI, specified, value);
		}

		public function createClassCondition(namespaceURI:String, value:String):IAttributeCondition
		{
			trace("ConditionFactory.createClassCondition(" + arguments + ")");
			return new ClassCondition(namespaceURI, value);
		}

		public function createPseudoClassCondition(namespaceURI:String, value:String):IAttributeCondition
		{
			trace("ConditionFactory.createPseudoClassCondition(" + arguments + ")");
			return new PseudoClassCondition(namespaceURI, value);
		}

		public function createOnlyChildCondition():ICondition
		{
			trace("ConditionFactory.createOnlyChildCondition(" + arguments + ")");
			return new OnlyChildCondition();
		}

		public function createOnlyTypeCondition():ICondition
		{
			trace("ConditionFactory.createOnlyTypeCondition(" + arguments + ")");
			return new OnlyTypeCondition();
		}

		public function createContentCondition(data:String):IContentCondition
		{
			trace("ConditionFactory.createContentCondition(" + arguments + ")");
			return null;
		}

	}
}
