
package com.newgonzo.web.css.selectors
{
	import org.w3c.css.sac.*;			

	public class DefaultConditionFactory implements IExtendedConditionFactory
	{
		public static const INSTANCE:DefaultConditionFactory = new DefaultConditionFactory();
		
		
		public function createAndCondition(first:ICondition, second:ICondition):ICombinatorCondition
		{
			return new AndCondition(first, second);
		}

		public function createOrCondition(first:ICondition, second:ICondition):ICombinatorCondition
		{
			// not used
			return null;
		}

		public function createNegativeCondition(condition:ICondition):INegativeCondition
		{
			// not used
			return null;
		}

		public function createPositionalCondition(position:int, typeNode:Boolean, type:Boolean):IPositionalCondition
		{
			// handled in FunctionalCondition
			return null;
		}

		public function createAttributeCondition(localName:String, namespaceURI:String, specified:Boolean, value:String):IAttributeCondition
		{
			return new AttributeCondition(localName, namespaceURI, specified, value);
		}

		public function createIdCondition(value:String):IAttributeCondition
		{
			return new IdCondition(value);
		}

		public function createLangCondition(lang:String):ILangCondition
		{
			return new LangCondition(lang);
		}

		public function createOneOfAttributeCondition(localName:String, namespaceURI:String, specified:Boolean, value:String):IAttributeCondition
		{
			return new OneOfAttributeCondition(localName, namespaceURI, specified, value);
		}

		public function createBeginHyphenAttributeCondition(localName:String, namespaceURI:String, specified:Boolean, value:String):IAttributeCondition
		{
			return new HyphenAttributeCondition(localName, namespaceURI, specified, value);
		}

		public function createPrefixAttributeCondition(localName:String, namespaceURI:String, specified:Boolean, value:String):IAttributeCondition
		{
			return new PrefixAttributeCondition(localName, namespaceURI, specified, value);
		}

		public function createSuffixAttributeCondition(localName:String, namespaceURI:String, specified:Boolean, value:String):IAttributeCondition
		{
			return new SuffixAttributeCondition(localName, namespaceURI, specified, value);
		}

		public function createSubstringAttributeCondition(localName:String, namespaceURI:String, specified:Boolean, value:String):IAttributeCondition
		{
			return new SubstringAttributeCondition(localName, namespaceURI, specified, value);
		}

		public function createClassCondition(namespaceURI:String, value:String):IAttributeCondition
		{
			return new ClassCondition(namespaceURI, value);
		}

		public function createPseudoClassCondition(namespaceURI:String, value:String, args:Array=null):IAttributeCondition
		{
			return new PseudoClassCondition(value, namespaceURI, args);
		}

		public function createOnlyChildCondition():ICondition
		{
			// handled in FunctionCondition
			return null;
		}

		public function createOnlyTypeCondition():ICondition
		{
			// handled in FunctionCondition
			return null;
		}

		public function createContentCondition(data:String):IContentCondition
		{
			return null;
		}
		
		public function createNegativeSelectorCondition(simpleSelector:ISimpleSelector):ICondition
		{
			return new NegativeSelectorCondition(simpleSelector);
		}
	}
}
