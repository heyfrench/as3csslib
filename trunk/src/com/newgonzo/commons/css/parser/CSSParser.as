package com.newgonzo.commons.css.parser
{
	import com.newgonzo.commons.css.dom.*;
	import com.newgonzo.commons.css.sac.*;
	import com.newgonzo.commons.parsing.Token;
	import com.newgonzo.commons.parsing.Tokenizer;
	
	public class CSSParser implements IParser
	{
		private var handler:IDocumentHandler = new DefaultDocumentHandler();
		private var selFactory:ISelectorFactory = new SelectorFactory();
		private var condFactory:IConditionFactory = new ConditionFactory();
		
		private var negated:Boolean = false;
		private var pseudoElement:String;
		
		private var tokenizer:Tokenizer;
		private var current:Token;
		
		public function CSSParser(selectorFactory:ISelectorFactory = null, conditionFactory:IConditionFactory = null)
		{
			this.selectorFactory = selectorFactory;
			this.conditionFactory = conditionFactory;
		}
		
		public function set documentHandler(value:IDocumentHandler):void
		{
			handler = value;
		}
		
		public function set selectorFactory(value:ISelectorFactory):void
		{
			if(!value) return;
			selFactory = value;
		}
		
		public function set conditionFactory(value:IConditionFactory):void
		{
			if(!value) return;
			condFactory = value;
		}
		
		public function parse(source:String):void
		{
			if(!tokenizer)
			{
				handler.startDocument(source);
				
				tokenizer = createTokenizer(source);
				nextIgnoreSpaces();
			}
			
			loop: while(current.type != Token.EOF)
			{
				trace("Style loop: " + current);
				
				var selectors:ISelectorList = parseSelectorList();
			
				
				if(selectors.length > 0)
				{
					handler.startSelector(selectors);
				}
				
				
				// what's left after the selector was parsed
				switch(current.type)
				{
					case CSSToken.LEFT_CURLY_BRACE:
						
						// parses up to }
						parseProperties();
						
						if(current.type != CSSToken.RIGHT_CURLY_BRACE)
						{
							throw new Error("Expected RIGHT_CURLY_BRACE but got " + current);
						}
						
						// consume right curly bracket and any spaces after.
						nextIgnoreSpaces();
						
						break;
						
					case Token.EOF:
						// loop will break itself after this
						break;	
					
					default:
						throw new Error("Unexpected (unsupported?) " + current);
						break;
				}
				
				if(selectors.length > 0)
				{
					handler.endSelector(selectors);
				}
			}
			
			handler.endDocument(source);
		}
		
		public function parseSelectors(source:String):ISelectorList
		{
			if(!tokenizer)
			{
				handler.startDocument(source);
				
				tokenizer = createTokenizer(source);
				nextIgnoreSpaces();
			}
			
			var list:ISelectorList = parseSelectorList();
			
			if(list.length > 0)
			{
				handler.startSelector(list);
			}
			
			return list;
		}
		
		protected function parseTokens():void
		{
			parseSelectorList();
		}
		
		protected function createTokenizer(source:String):Tokenizer
		{
			return new CSSTokenizer(source);
		}
		
		protected function skipSpaces():void
		{
			if(current.type == CSSToken.SPACE)
			{
				nextIgnoreSpaces();
			}
		}
		
		protected function nextIgnoreSpaces():Token
		{
			return next(true);
		}
		
		protected function next(ignoreSpaces:Boolean = false):Token
		{
			var token:Token;
			
			loop: while(true)
			{
				token = tokenizer.nextToken();
				
				trace("nextIgnoreSpace: token " + token);
				
				switch(token.type)
				{
					case CSSToken.COMMENT:
						handler.comment(token.value);
						// keep looping
						break;
					
					// ignore spaces?
					case CSSToken.SPACE:
						if(!ignoreSpaces)
						{
							break loop;
						}
						
						// else keep looping
						break;
						
					default:
						break loop;
				}
			}
			
			current = token;
			return token;
		}
		
		
		protected function parseSelectorList():ISelectorList
		{
			var list:SelectorList = new SelectorList();
			list.append(parseSelector());
			
			while(true)
			{
				if(current.type != CSSToken.COMMA)
				{
					return list;
				}
				
				nextIgnoreSpaces();
				list.append(parseSelector());
			}
			
			return list;
			
		}
		
		protected function parseSelector():ISelector
		{
			var selector:ISelector = parseSimpleSelector();
			
			loop: while(true)
			{
				trace("Selector start " + current);
				switch(current.type)
				{
					case CSSToken.IDENTIFIER:
					case CSSToken.ANY:
					case CSSToken.HASH:
					case CSSToken.DOT:
					case CSSToken.LEFT_BRACKET:
					case CSSToken.IDENTIFIER:
						//if(pseudoElement) throw new Error();
						selector = selFactory.createDescendantSelector(selector, parseSimpleSelector());
						break;
					
					// E + F	
					case CSSToken.PLUS:
						nextIgnoreSpaces();
						selector = selFactory.createDirectAdjacentSelector(1, selector, parseSimpleSelector());
						break;
						
					// E < F
					case CSSToken.PRECEDE:
						nextIgnoreSpaces();
						selector = selFactory.createChildSelector(selector, parseSimpleSelector());
						break;
						
					// E ~ F
					case CSSToken.TILDE:
						nextIgnoreSpaces();
						selector = selFactory.createGeneralSiblingSelector(1, selector, parseSimpleSelector());
						break;
					
					default:
						break loop;
				}
			}
			
			trace("RETURNING SELECTOR");
			return selector;
		}
		
		protected function parseSimpleSelector():ISimpleSelector
		{
			var selector:ISimpleSelector;
			var condition:ICondition;
			var func:Token;
			var args:Array;
			
			trace("Simple selector start: " + current);
			switch(current.type)
			{
				// E
				case CSSToken.IDENTIFIER:
					selector = selFactory.createElementSelector(null, current.value);
					next();
					break;
				
				// *	
				case CSSToken.ANY:
					selector = selFactory.createAnyNodeSelector();
					next();
					break;
					
				case Token.EOF:
					return selector;
					
				default:
					selector = selFactory.createAnyNodeSelector();
					break;
			}
			
			loop: while(true)
			{
					trace("Condition switch " + current);
					switch(current.type)
					{	
						// #id
						case CSSToken.HASH:
							
							condition = condFactory.createIdCondition(current.value);
							next();
							break;
						
						// .class
						case CSSToken.DOT:
							
							// combine class conditions
							while(current.type == CSSToken.DOT)
							{
								// no spaces allowed after .
								next();
								
								if(current.type != CSSToken.IDENTIFIER)
								{
									throw new Error("Expected token IDENTIFIER after token DOT at " + current);
								}
								
								if(condition)
								{
									condition = condFactory.createAndCondition(condition, condFactory.createClassCondition(null, current.value));
								}
								else
								{
									condition = condFactory.createClassCondition(null, current.value);
								}
							
								nextIgnoreSpaces();
							}
							
							break;
						
						// [attr], [attr=val], [att~=value], etc
						case CSSToken.LEFT_BRACKET:
							
							// add to condition as a combinator if condition
							// already exists
							while(current.type == CSSToken.LEFT_BRACKET)
							{
								nextIgnoreSpaces();
								
								if(condition)
								{
									condition = condFactory.createAndCondition(condition, parseAttributeCondition());
								}
								else
								{
									condition = parseAttributeCondition();
								}
							}
							
							// break LEFT_BRACKET case
							break;
							
						// 
						case CSSToken.COLON:
													
							nextIgnoreSpaces();
							
							// ::
							if(current.type == CSSToken.COLON)
							{
								// pseudo-element
								nextIgnoreSpaces();
								
								if(current.type != CSSToken.IDENTIFIER)
								{
									throw new Error("Expected IDENTIFIER for pseudo-element but got " + current);
								}
								
								pseudoElement = current.value;
								nextIgnoreSpaces();
								break;
							}
							
							// pseudo-class
							trace("Pseudo-class switch " + current);
							switch(current.type)
							{
								// :first-child
								case CSSToken.IDENTIFIER:
									
									switch(current.value)
									{
										case "only-of-type":
											condition = condFactory.createOnlyTypeCondition();
											break;
											
										case "only-child":
											condition = condFactory.createOnlyChildCondition();
											break;
										
										default:									
											condition = condFactory.createPseudoClassCondition(null, current.value);
											break;
									}
									
									nextIgnoreSpaces();
									break;
								
								case CSSToken.FUNCTION:
									
									func = current;
									args = parseArguments();
									
									trace("Function switch: " + func + " + arguments: " + args.join(","));
									switch(func.value)
									{
										case "nth-child":
										case "nth-of-type":
											
											break;
										case "first-child":
										case "first-of-type":
										
											break;
											
										case "nth-last-child":
										case "nth-last-of-type":
										
											break;
										case "last-child":
										case "last-of-type":
									
											break;
											
										case "lang":
										
											condition = condFactory.createLangCondition(args[0] as String);
											break;
										
										default:
											trace("Unknown function " + current + ", arguments: " + args.join(","));
											break;
									}
									
									// consume right brace
									next();
									
									//condition = condFactory.createPositionalCondition(
									break;
									
																	
							}				
							
							break;
							
						case CSSToken.NOT:
						
							throw new Error("Negatives not supported yet.");
						
							/*
							if(negated)
							{
								throw new Error("Negations (:not()) cannot be nested.");
							}
							
							negated = true;
							// temp
							//parseSimpleSelector();
							
							//condition = selFactory.createNegativeCondition(selector, 
							/selector = selFactory.createConditionalSelector(selector, );
							
							nextIgnoreSpaces();
							
							
							// end of function
							if(current.type != CSSToken.RIGHT_BRACE)
							{
								throw new Error("Expected RIGHT_BRACE but got " + current);
							}
							
							// end negation block
							negated = false;
							nextIgnoreSpaces();
							*/
							break;
							
						case Token.EOF:
							break loop;
						
						default:
							trace("Breaking loop -- not a simple selector token");
							break loop;
					} // end outer switch(current.type)
					
					if(condition)
					{
						if(negated)
						{
							condition = condFactory.createNegativeCondition(condition);
						}
						
						selector = selFactory.createConditionalSelector(selector, condition);
					}
			} // end loop:
			
			skipSpaces();
			return selector;
		}
		
		protected function parseAttributeCondition():IAttributeCondition
		{
			// attribute test
			var attribute:Token;
			var operation:Token;
			var compare:Token;
			var condition:IAttributeCondition;
			
			// attr has to be an identifier
			if(current.type != CSSToken.IDENTIFIER)
			{
				throw new Error("Expeced IDENTIFIER after LEFT_BRACKET but got " + current);
			}
			
			attribute = current;
			operation = nextIgnoreSpaces();
			
			trace("Attribute " + attribute);
			trace("Operation switch " + operation);
			switch(operation.type)
			{
				// [attr]
				case CSSToken.RIGHT_BRACKET:
				
					condition = condFactory.createAttributeCondition(attribute.value, null, false, null);
					// consume bracket and leading spaces
					nextIgnoreSpaces();
					break;
				
				// [attr=, attr~=, attr^=, etc
				case CSSToken.EQUAL:
				case CSSToken.INCLUDES:
				case CSSToken.DASHMATCH:
				case CSSToken.PREFIXMATCH:
				case CSSToken.SUFFIXMATCH:
				case CSSToken.SUBSTRINGMATCH:
				
					nextIgnoreSpaces();
					
					// "value" or value
					trace("Operation value switch " + current);
					switch(current.type)
					{
						case CSSToken.STRING:
						case CSSToken.IDENTIFIER:
							
							compare = current;
							nextIgnoreSpaces();
							break;
							
						default:
							throw new Error("Expected STRING or IDENTIFIER but got " + current);
					}
					
					// ] should close the condition if all went well
					if(current.type != CSSToken.RIGHT_BRACKET)
					{
						throw new Error("Expected RIGHT_BRACKET after condition but got " + current);
					}
					
					// create condition based on type of operation
					switch(operation.type)
					{
						case CSSToken.EQUAL:
							
							condition = condFactory.createAttributeCondition(attribute.value, null, false, compare.value);
							break;
							
						case CSSToken.INCLUDES:
							condition = condFactory.createOneOfAttributeCondition(attribute.value, null, false, compare.value);
							break;
							
						case CSSToken.DASHMATCH:
							condition = condFactory.createBeginHyphenAttributeCondition(attribute.value, null, false, compare.value);
							break;
							
						case CSSToken.PREFIXMATCH:
							condition = condFactory.createPrefixAttributeCondition(attribute.value, null, false, compare.value);
							break;
							
						case CSSToken.SUFFIXMATCH:
							condition = condFactory.createSuffixAttributeCondition(attribute.value, null, false, compare.value);
							break;
							
						case CSSToken.SUBSTRINGMATCH:
							condition = condFactory.createSubstringAttributeCondition(attribute.value, null, false, compare.value);
							break;
					}
					
					// eat trailing bracket and preceding whitespace
					nextIgnoreSpaces();
			}
		
			return condition;
		}
		
		/**
		* Divides arguments into strings for general use
		*/
		protected function parseArguments():Array
		{
			// consume (
			nextIgnoreSpaces();
			
			var args:Array = new Array();
			var arg:String = "";
			
			// whitespace before and after an argument is chopped
			loop: while(true)
			{
				trace("Argument switch " + current);
				switch(current.type)
				{
					case CSSToken.COMMA:
						
						args.push(arg);
						nextIgnoreSpaces();
						arg = "";
						break;
						
					case CSSToken.STRING:
					case CSSToken.IDENTIFIER:
					case CSSToken.NUMBER:
					case CSSToken.PLUS:
					case CSSToken.MINUS:
					case CSSToken.DIVIDE:
					case CSSToken.ANY:
					case CSSToken.SPACE:
						
						arg += current.value;
						next();
						break;
						
					case CSSToken.RIGHT_BRACE:
						args.push(arg);
						break loop;
				
					default:
						throw new Error("Unexpected " + current);
				}
			}
			
			return args;
		}
		
		protected function parseProperties():void
		{			
			// consume {
			nextIgnoreSpaces();
						
			var foundColon:Boolean = false;
			var prop:String = "";
			var value:String = "";
			
			loop: while(true)
			{
				switch(current.type)
				{
					case CSSToken.IDENTIFIER:
						
						if(foundColon)
						{
							value += current.value;
							
							// don't ignore spaces in our quick-n-dirty prop/value setup
							next();
						}
						else if(prop.length == 0)
						{
							prop = current.value;
							nextIgnoreSpaces();						
						}
						else
						{
							//another identifier after prop identifier set
							throw new Error("Unexpected IDENTIFIER found at " + current);
						}
						
						break;
						
					case CSSToken.COLON:
					
						foundColon = true;					
						nextIgnoreSpaces();
						break;
						
					case CSSToken.SEMI_COLON:
					
						if(prop && value)
						{
							handler.property(prop, value, false);
						}
						
						prop = value = "";
						foundColon = false;
						nextIgnoreSpaces();
						break;
					
					case Token.EOF:
						throw new Error("Missing ending RIGHT_CURLY_BRACE");
						
					case CSSToken.RIGHT_CURLY_BRACE:
					
						if(prop && value)
						{
							handler.property(prop, value, false);
						}
						
						break loop;

					default:
					
						if(foundColon)
						{
							// eat everything else
							value += current.value;
							nextIgnoreSpaces();
						}
						else
						{
							throw new Error("Unexpected " + current);
						}
						
						break;							
				}
			}
		}
	}
}