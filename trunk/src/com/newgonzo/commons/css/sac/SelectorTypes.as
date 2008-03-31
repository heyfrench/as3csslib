package com.newgonzo.commons.css.sac
{
	import com.newgonzo.commons.parsing.SyntaxToken;
	
	public class SelectorTypes
	{
		/* simple selectors */
		
		/**
		* This is a conditional selector.
		* example:
		* <pre class="example">
		*   simple[role="private"]
		*   .part1
		*   H1#myId
		*   P:lang(fr).p1
		* </pre>
		*
		* @see ConditionalSelector
		*/
		public static const SAC_CONDITIONAL_SELECTOR:int = 0;
		
		/**
		* This selector matches any node.
		* @see SimpleSelector
		*/    
		public static const SAC_ANY_NODE_SELECTOR:int = 1;
		
		/**
		* This selector matches the root node.
		* @see SimpleSelector
		*/    
		public static const SAC_ROOT_NODE_SELECTOR:int = 2;
		
		/**
		* This selector matches only node that are different from a specified one.
		* @see NegativeSelector
		*/    
		public static const SAC_NEGATIVE_SELECTOR:int = 3;
		
		/**
		* This selector matches only element node.
		* example:
		* <pre class="example">
		*   H1
		*   animate
		* </pre>
		* @see ElementSelector
		*/
		public static const SAC_ELEMENT_NODE_SELECTOR:int = 4;
		
		/**
		* This selector matches only text node.
		* @see CharacterDataSelector
		*/
		public static const SAC_TEXT_NODE_SELECTOR:int = 5;
		
		/**
		* This selector matches only cdata node.
		* @see CharacterDataSelector
		*/
		public static const SAC_CDATA_SECTION_NODE_SELECTOR:int = 6;
		
		/**
		* This selector matches only processing instruction node.
		* @see ProcessingInstructionSelector
		*/
		public static const SAC_PROCESSING_INSTRUCTION_NODE_SELECTOR:int = 7;
		
		/**
		* This selector matches only comment node.
		* @see CharacterDataSelector
		*/    
		public static const SAC_COMMENT_NODE_SELECTOR:int = 8;
		/**
		* This selector matches the 'first line' pseudo element.
		* example:
		* <pre class="example">
		*   :first-line
		* </pre>
		* @see ElementSelector
		*/
		public static const SAC_PSEUDO_ELEMENT_SELECTOR:int = 9;
		
		/* combinator selectors */
		
		/**
		* This selector matches an arbitrary descendant of some ancestor element.
		* example:
		* <pre class="example">
		*   E F
		* </pre>
		* @see DescendantSelector
		*/    
		public static const SAC_DESCENDANT_SELECTOR:int = 10;
		
		/**
		* This selector matches a childhood relationship between two elements.
		* example:
		* <pre class="example">
		*   E > F
		* </pre>
		* @see DescendantSelector
		*/    
		public static const SAC_CHILD_SELECTOR:int = 11;
		/**
		* This selector matches two selectors who shared the same parent in the
		* document tree and the element represented by the first sequence
		* immediately precedes the element represented by the second one.
		* example:
		* <pre class="example">
		*   E + F
		* </pre>
		* @see SiblingSelector
		*/
		public static const SAC_DIRECT_ADJACENT_SELECTOR:int = 12;
		
		/**
		* This selector matches two selectors who shared the same parent in the
		* document tree and the element represented by the first sequence
		* precedes (directly or indirectly) the element represented by the second one.
		* example:
		* <pre class="example">
		*   E ~ F
		* </pre>
		* @see SiblingSelector
		*/
		public static const SAC_GENERAL_SIBLING_SELECTOR:int = 13;
	}
}