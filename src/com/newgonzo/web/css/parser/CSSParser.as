package com.newgonzo.web.css.parser
{
	import com.newgonzo.web.css.CSSMediaType;
	import com.newgonzo.web.css.selectors.DefaultConditionFactory;
	import com.newgonzo.web.css.selectors.DefaultSelectorFactory;
	import com.newgonzo.web.css.selectors.IExtendedConditionFactory;
	import com.newgonzo.web.css.selectors.IExtendedSelectorFactory;
	import com.newgonzo.commons.parsing.Token;
	import com.newgonzo.commons.parsing.Tokenizer;
	
	import flash.utils.Dictionary;
	
	import org.w3c.css.sac.*;	

	public class CSSParser implements ICSSParser
	{
		private var docHandler:IDocumentHandler;
		private var errHandler:IErrorHandler;
		private var selFactory:IExtendedSelectorFactory;
		private var condFactory:IExtendedConditionFactory;
		
		private var negated:Boolean = false;
		private var pseudoElement:String;
		
		private var tokenizer:Tokenizer;
		private var current:Token;
		private var currentType:int;
		
		private var namespaceDict:Dictionary;
		private var defaultNamespace:String;
		
		private var charsetAllowed:Boolean = true;
		private var importAllowed:Boolean = true;
		private var namespaceAllowed:Boolean = true;
		
		public function CSSParser(selectorFactory:IExtendedSelectorFactory = null, conditionFactory:IExtendedConditionFactory = null)
		{
			// NOTE: these don't work for some reason when defined staticly
			docHandler = DefaultDocumentHandler.INSTANCE;
			errHandler = DefaultErrorHandler.INSTANCE;
			selFactory = DefaultSelectorFactory.INSTANCE;
			condFactory = DefaultConditionFactory.INSTANCE;
			
			if(selectorFactory) selFactory = selectorFactory;
			if(conditionFactory) condFactory = conditionFactory;
			
			namespaceDict = new Dictionary();
		}
		
		public function get parserVersion():String
		{
			return "http://www.w3.org/TR/css3-roadmap";
		}
		
		public function set documentHandler(value:IDocumentHandler):void
		{
			docHandler = value;
		}
		public function get documentHandler():IDocumentHandler
		{
			return docHandler;
		}
		
		public function set errorHandler(value:IErrorHandler):void
		{
			errHandler = value;
		}
		public function get errorHandler():IErrorHandler
		{
			return errHandler;
		}
		
		public function set selectorFactory(value:ISelectorFactory):void
		{
			selFactory = value as IExtendedSelectorFactory;
		}
		public function get selectorFactory():ISelectorFactory
		{
			return selFactory;
		}
		
		public function set conditionFactory(value:IConditionFactory):void
		{
			condFactory = value as IExtendedConditionFactory;
		}
		public function get conditionFactory():IConditionFactory
		{
			return condFactory;
		}
		
		public function parse(source:String):void
		{
			parseStyleSheet(source);
		}
		
		public function parseStyleSheet(source:String):void
		{
			try
			{
				tokenizer = createTokenizer(source);
				docHandler.startDocument(source);
				nextIgnoreSpaces();
				
				loop: while(currentType != Token.EOF)
				{
					parseRuleInternal();
				}
				
				// should be at end of document here
				if(currentType != Token.EOF)
				{
					throw createSyntaxError("Expected EOF but got " + current);
				}
				
				docHandler.endDocument(source);
			}
			catch(error:CSSParseError)
			{
				errorHandler.error(error);
			}
			catch(error:Error)
			{
				reportFatal("Unexpected error caught in parseStyleSheet", CSSErrorTypes.SAC_UNSPECIFIED_ERR, error);
			}
			finally
			{
				cleanup();
			}
		}
		
		public function parseMedia(source:String):ISACMediaList
		{
			var list:ISACMediaList;
			
			try
			{
				tokenizer = createTokenizer(source);
				nextIgnoreSpaces();
				
				list = parseMediaList();
				
				if(currentType != Token.EOF)
				{
					throw createSyntaxError("Expected EOF but got " + current);
				}
			}
			catch(error:CSSParseError)
			{
				errorHandler.error(error);
			}
			catch(error:Error)
			{
				reportFatal("Unexpected error caught in parseMedia", CSSErrorTypes.SAC_UNSPECIFIED_ERR, error);
			}
			finally
			{
				cleanup();
				return list;
			}
		}
		
		public function parseSelectors(source:String):ISelectorList
		{
			var list:ISelectorList;
			
			try
			{
				tokenizer = createTokenizer(source);
				nextIgnoreSpaces();
				
				list = parseSelectorList();
			}
			catch(error:CSSParseError)
			{
				errorHandler.error(error);
			}
			catch(error:Error)
			{
				reportFatal("Unexpected error caught in parseSelectors", CSSErrorTypes.SAC_UNSPECIFIED_ERR, error);
			}
			finally
			{
				// free the tokenizer
				cleanup();
				return list;
			}
		}
		
		public function parseRule(source:String):void
		{
			try
			{
				tokenizer = createTokenizer(source);
				nextIgnoreSpaces();
				
				parseRuleInternal();
			}
			catch(error:CSSParseError)
			{
				errorHandler.error(error);
			}
			catch(error:Error)
			{
				reportFatal("Unexpected error caught in parseRule", CSSErrorTypes.SAC_UNSPECIFIED_ERR, error);
			}
			finally
			{
				// free the tokenizer
				cleanup();
			}
		}
		
		
		public function parsePriority(source:String):Boolean
		{
			var important:Boolean = false;
			
			try
			{
				tokenizer = createTokenizer(source);
				nextIgnoreSpaces();
				
				switch(currentType)
				{
					case CSSToken.IMPORTANT_SYMBOL:
						important = true;
						break;
					case Token.EOF:
						break;
					default:
						throw createSyntaxError("Expected IMPORTANT_SYMBOL or EOF but got " + current);
						break;
				}
			}
			catch(error:CSSParseError)
			{
				errorHandler.error(error);
			}
			catch(error:Error)
			{
				reportFatal("Unexpected error caught in parsePriority", CSSErrorTypes.SAC_UNSPECIFIED_ERR, error);
			}
			finally
			{
				// free the tokenizer
				cleanup();
				return important;
			}
			
			return false;
		}
		
		public function parsePropertyValue(source:String):ILexicalUnit
		{
			var unit:ILexicalUnit;
			
			try
			{
				tokenizer = createTokenizer(source);
				nextIgnoreSpaces();
				
				unit = parseExpression(false);
				
				if(currentType != Token.EOF)
				{
					throw createSyntaxError("Expected EOF but got " + current);
				}
			}
			catch(error:CSSParseError)
			{
				errHandler.error(error);
			}
			catch(error:Error)
			{
				reportFatal("Unexpected error caught in parsePropertyValue", CSSErrorTypes.SAC_UNSPECIFIED_ERR, error);
			}
			finally
			{
				// free the tokenizer
				cleanup();
				return unit;
			}
		}
		
		public function parseStyleDeclaration(source:String):void
		{
			try
			{
				tokenizer = createTokenizer(source);
				nextIgnoreSpaces();
				
				parseStyleDeclarationInternal();
			}
			catch(error:CSSParseError)
			{
				errHandler.error(error);
			}
			catch(error:Error)
			{
				reportFatal("Unexpected error caught in parseStyleDeclaration", CSSErrorTypes.SAC_UNSPECIFIED_ERR, error);
			}
			finally
			{
				cleanup();
			}
		}
		
		
		/* Internal parsing methods */
		protected function skipSpaces():void
		{
			if(currentType == CSSToken.SPACE)
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
				
				switch(token.type)
				{
					// ignore spaces?
					case CSSToken.SPACE:
						if(!ignoreSpaces)
						{
							break loop;
						}
						
						// else keep looping
						break;
					
					case CSSToken.COMMENT:
						docHandler.comment(token.value);
						// keep looping
						break;
					
					// SGML comments do not delimit CSS comments, but should be ignored 
					// see http://www.w3.org/TR/CSS2/syndata.html#comments
					case CSSToken.CDO:
					case CSSToken.CDC:
						// ignore, keep looping
						break;
					
					case Token.UNKNOWN:
						// report the unknown token
						//reportError("Unknown token at " + token);
						tokenizer.recover();
						break loop;
						
					default:
						break loop;
				}
			}
			
			current = token;
			currentType = token.type;
			return token;
		}
		
		protected function look():Token
		{
			try
			{
				return tokenizer.lookAhead();
			}
			catch(e:Error)
			{
				// report the error
				tokenizer.recover();
				syntaxError("Tokenizer error while looking ahead: " + e);
			}
			
			return null;
		}
		
		protected function parseRuleInternal():void
		{
			/* 
			TODO:
			From http://www.w3.org/TR/css3-namespace/
			
			Any @namespace rules must follow all @charset and @import 
			rules and precede all other non-ignored at-rules and rule sets 
			in a style sheet. For CSS syntax this adds [ namespace [S|CDO|CDC]* ]*  
			immediately after [ import [S|CDO|CDC]* ]* in the stylesheet grammar.
			*/
			
			switch(currentType)
			{
				case CSSToken.AT_RULE:
				
					switch(current.value)
					{
						case "charset":
						
							if(!charsetAllowed)
							{
								syntaxError("@charset must appear before @namespace and style rules.");
								return;
							}
							
							nextIgnoreSpaces();
							parseCharsetRule();
							break;
						
						case "import":
							
							if(!importAllowed)
							{
								syntaxError("@import must appear before @namespace and style rules");
								return;
							}
							
							nextIgnoreSpaces();
							parseImportRule();
							break;
							
						case "namespace":
						
							if(!namespaceAllowed)
							{
								syntaxError("@namespace must appear before style rules and after @import and @charset rules");
								return;
							}
						
							// @import and @charset must appear before @namespace
							importAllowed = false;
							charsetAllowed = false;
						
							nextIgnoreSpaces();
							parseNamespaceRule();
							break;
							
						case "media":
						
							importAllowed = false;
							charsetAllowed = false;
							namespaceAllowed = false;
						
							nextIgnoreSpaces();
							parseMediaRule();
							break;
							
						default:
						
							importAllowed = false;
							charsetAllowed = false;
							namespaceAllowed = false;
						
							parseAtRule();
							break;
					}
					
					break;
					
				case Token.UNKNOWN:
					syntaxError("Unexpected UNKNOWN at " + current);
					break;
					
				default:
					importAllowed = false;
					charsetAllowed = false;
					namespaceAllowed = false;
					
					parseRuleSet();
					break;
			}
		}
		
		protected function parseAtRule():void
		{
			docHandler.ignorableAtRule(current.value);
			nextIgnoreSpaces();
		}
		
		protected function parseCharsetRule():void
		{
			var value:String;
			
			if(currentType != CSSToken.STRING)
			{
				syntaxError("Expected STRING paring @charset rule but got " + current);
				return;
			}
			
			var charset:String = current.value;
			//docHandler.ignorableAtRule(
			
			// consume string
			nextIgnoreSpaces();
			
			if(currentType != CSSToken.SEMI_COLON)
			{
				syntaxError("Missing SEMI_COLON after @charset rule.");
				return;
			}
			
			// consume semi-colon
			nextIgnoreSpaces();
		}
		
		protected function parseImportRule():void
		{
			var uri:String;
			
			switch(currentType)
			{
				case CSSToken.URI:
				case CSSToken.STRING:
					uri = current.value;
					break;
				
				default:
					syntaxError("Error parsing import rule: expected URI or STRING for but got " + current);
					return;
			}
			
			nextIgnoreSpaces();
			var mediaList:MediaList;
			
			
			if(currentType == CSSToken.IDENTIFIER || currentType == CSSToken.STRING)
			{
				mediaList = parseMediaList();
			}
			else
			{
				mediaList = new MediaList();
				mediaList.push(CSSMediaType.ALL);
			}
			
			docHandler.importStyle(uri, mediaList, null);
			
			if(currentType == CSSToken.SEMI_COLON)
			{
				nextIgnoreSpaces();
			}
		}
		
		protected function parseMediaRule():void
		{
			if(currentType != CSSToken.IDENTIFIER)
			{
				syntaxError("Expected IDENTIFIER after media rule but got " + current);
				return;
			}
			
			var mediaList:MediaList = parseMediaList();
			
			if(!mediaList.length)
			{
				return;
			}
			
			docHandler.startMedia(mediaList);
			
			// consume {
			nextIgnoreSpaces();
			
			// get rulesets within this media
			while(currentType != CSSToken.RIGHT_CURLY_BRACE)
			{
				parseRuleSet();
				
				if(currentType == Token.EOF)
				{
					syntaxError("Error parsing media rule: unexepcted EOF at " + current);
					return;
				}
			}
			
			// gobble right curly brace
			nextIgnoreSpaces();
			
			docHandler.endMedia(mediaList);
		}
		
		protected function parseMediaList():MediaList
		{
			var mediaList:MediaList = new MediaList();
			
			mediaList.push(current.value);
			nextIgnoreSpaces();
			
			while(currentType == CSSToken.COMMA)
			{
				// cosume comma
				nextIgnoreSpaces();
				
				// media list
				if(currentType == CSSToken.STRING || currentType == CSSToken.IDENTIFIER)
				{
					mediaList.push(current.value);
					nextIgnoreSpaces();
				}
				else
				{
					syntaxError("Error parsing media list: expected STRING or IDENTIFIER but got " + current);
				}
			}
			
			return mediaList;
		}
		
		protected function parseNamespaceRule():void
		{
			var prefix:String;
			var uri:String;
			
			if(currentType == CSSToken.IDENTIFIER)
			{
				prefix = current.value;
				nextIgnoreSpaces();
			}
			
			switch(currentType)
			{
				case CSSToken.URI:
				case CSSToken.STRING:
					uri = current.value;
					break;
				
				default:
					syntaxError("Expected URI or STRING for namespace rule but got " + current);
					return;
			}
			
			nextIgnoreSpaces();
			
			if(prefix)
			{
				namespaceDict[prefix] = uri;
			}
			else
			{
				// no prefix was defiend, so this is a default namespace declaration
				//trace("SETTING DEFAULT NAMESPACE TO " + uri);
				defaultNamespace = uri;
			}
			
			docHandler.namespaceDeclaration(prefix, uri);
			
			if(currentType == CSSToken.SEMI_COLON)
			{
				nextIgnoreSpaces();
			}
		}
		
		protected function parseRuleSet():void
		{
			var selectors:ISelectorList;
			
			try
			{
				selectors = parseSelectorList();
				
				// start selector
				docHandler.startSelector(selectors);
			
				// what's left after the selector was parsed
				if(currentType == CSSToken.LEFT_CURLY_BRACE)
				{
					// consume { and parse up to }
					nextIgnoreSpaces();
					
					// parse style properties
					parseStyleDeclarationInternal();
					
					if(currentType != CSSToken.RIGHT_CURLY_BRACE)
					{
						syntaxError("Expected RIGHT_CURLY_BRACE but got " + current);
						return;
					}
					
					// consume right curly bracket and any spaces before
					nextIgnoreSpaces();
					
					docHandler.endSelector(selectors);
				}
				else
				{
					syntaxError("Expected LEFT_CURLY_BRACE but got " + current);
					return;
				}
			}
			catch(error:Error)
			{
				syntaxError("Error parsing selector list", error);
			}
		}
		
		protected function parseSelectorList():ISelectorList
		{
			var selector:ISelector = parseSelector();
			
			var list:SelectorList = new SelectorList();
			list.append(selector);
			
			while(true)
			{
				if(currentType == Token.UNKNOWN)
				{
					syntaxError("Encountered UNKNOWN token parsing selector list at " + current);
				}
				
				if(currentType != CSSToken.COMMA)
				{
					break;
				}
				
				// consume comma
				nextIgnoreSpaces();
				
				selector = parseSelector();
				list.append(selector);
			}
			
			return list;
			
		}
		
		protected function parseSelector():ISelector
		{
			var selector:ISelector = parseSimpleSelector();
			
			loop: while(true)
			{
				switch(currentType)
				{
					case CSSToken.IDENTIFIER:
					case CSSToken.ANY:
					case CSSToken.VERTICAL_BAR:
					case CSSToken.HASH:
					case CSSToken.DOT:
					case CSSToken.LEFT_BRACKET:
					case CSSToken.COLON:
					case CSSToken.NOT:
						//if(pseudoElement) throw new CSSError(); // one at a time
						selector = selFactory.createDescendantSelector(selector, parseSimpleSelector());
						break;
					
					// E + F	
					case CSSToken.PLUS:
						nextIgnoreSpaces();
						// TODO: Define node types and replace this number
						selector = selFactory.createDirectAdjacentSelector(1, selector, parseSimpleSelector());
						break;
						
					// E > F
					case CSSToken.PRECEDE:
						nextIgnoreSpaces();
						selector = selFactory.createChildSelector(selector, parseSimpleSelector());
						break;
						
					// E ~ F
					case CSSToken.TILDE:
						nextIgnoreSpaces();
						// TODO: Define node types and replace this number
						selector = selFactory.createGeneralSiblingSelector(1, selector, parseSimpleSelector());
						break;
						
					case Token.UNKNOWN:
						syntaxError("Encountered UNKNOWN token parsing selector at " + current);
						selector = null;
						break loop;
						
					default:
						break loop;
				}
			}
			
			// unset any pseudos or negations left behind
			pseudoElement = null;
			negated = false;
			
			return selector;
		}
		
		protected function parseSimpleSelector():ISimpleSelector
		{
			//trace("parseSimpleSelector(): " + current);
			
			var selector:ISimpleSelector;
			var condition:ICondition;
			var newCondition:ICondition;
			var func:Token;
			var args:Array;
			
			//check for namespace
			var ns:String = parseNamespace();
			
			// ns is defaultNamespace if no namespace was parsed
			// if ns == "" then explicitly NO namespace
			if(ns == null)
			{
				ns = defaultNamespace;
			}
			
			//trace("Simple selector start: " + current);
			
			// Parse selector part of simple selector
			// by definition, a simple selector must start with and can only
			// contain one of ANY or IDENTIFIER, and is then followed by conditions			
			switch(currentType)
			{
				// E or ns
				case CSSToken.IDENTIFIER:
				
					selector = selFactory.createElementSelector(ns, current.value);
					next();
					break;
				
				// *
				case CSSToken.ANY:
					selector = selFactory.createAnyNodeSelector(ns);
					next();
					break;
					
				case Token.EOF:
				
					if(selector)
					{
						return selector;
					}
					else
					{
						throw createSyntaxError("Unexpected EOF parsing simple selector at " + current);
					}
					
					break;
					
				case Token.UNKNOWN:
					throw createSyntaxError("Encountered UNKNOWN token parsing simple selector at " + current);
					
				case CSSToken.HASH:
				case CSSToken.DOT:
				case CSSToken.LEFT_BRACKET:
				case CSSToken.COLON:
				case CSSToken.NOT:
				case CSSToken.HASH:
					break;
					
				default:
					throw createSyntaxError("Unexpected " + current + " while parsing simple selector.");
			}
			
			// Begin selector condition parsing
			loop: while(true)
			{
				newCondition = null;
			
				//trace("Condition switch " + current);
				switch(currentType)
				{	
					// #id
					case CSSToken.HASH:
						
						newCondition = condFactory.createIdCondition(current.value);
						next();
						break;
					
					// .class
					case CSSToken.DOT:
						
						// no spaces allowed after .
						next();
						
						if(currentType != CSSToken.IDENTIFIER)
						{
							throw createSyntaxError("Expected token IDENTIFIER after token DOT at " + current);
						}
						
						newCondition = condFactory.createClassCondition(ns, current.value);
						next();
						
						break;
					
					// [attr], [attr=val], [att~=value], etc
					case CSSToken.LEFT_BRACKET:
						
						nextIgnoreSpaces();
						
						newCondition = parseAttributeCondition();
						
						// break LEFT_BRACKET case
						break;
						
					// 
					case CSSToken.COLON:
												
						nextIgnoreSpaces();
						
						// pseudo-class or pseudo-element
						
						//trace("Pseudo switch " + current);
						switch(currentType)
						{
							case CSSToken.COLON:
							
								// pseudo-element
								nextIgnoreSpaces();
								
								if(currentType != CSSToken.IDENTIFIER)
								{
									throw createSyntaxError("Expected IDENTIFIER after double COLON but got " + current);
								}
								
								if(negated)
								{
									throw createSyntaxError("Pseudo-elements cannot be negated");
								}
								
								pseudoElement = current.value;
								
								// FIXME
								throw createParseError("Pseudo-elements not supported.", CSSErrorTypes.SAC_NOT_SUPPORTED_ERR);
								
								//next();
								//break;
							
							// :first-child
							case CSSToken.IDENTIFIER:
								
								switch(current.value)
								{
									// In CSS 2.1, :before, :after, :first-letter and :first-line
									// were pseudo-elements
									case "first-letter":
									case "first-line":
									case "before":
									case "after":
									
										if(negated)
										{
											throw createSyntaxError("Pseudo-elements cannot be negated");
										}
									
										pseudoElement = current.value;
										
										// FIXME
										throw createParseError("Pseudo-elements not supported.", CSSErrorTypes.SAC_NOT_SUPPORTED_ERR);
										
										//break;
									
									default:
										newCondition = condFactory.createPseudoClassCondition(ns, current.value);
										break;
								}
								
								next();
								break;
								
							case CSSToken.FUNCTION:
								
								func = current;
								nextIgnoreSpaces();
								args = parsePseudoArguments();
								
								//trace("Function switch: " + func + " value: " + func.value + "arguments: " + args.join(","));
								switch(func.value)
								{
									case "lang":
									
										newCondition = condFactory.createLangCondition(args[0] as String);
										break;
									
									default:
										newCondition = condFactory.createPseudoClassCondition(ns, func.value, args);
										break;
								}
								
								// consume right brace
								next();
								break;
						}				
						
						break;
						
					case CSSToken.NOT:
					
						if(negated)
						{
							throw createSyntaxError("The negation pseudo-class (:not()) cannot be nested.");
						}
						
						negated = true;
						
						// gobble :not(
						nextIgnoreSpaces();
						
						//trace("NOT: Selector is " + selector);
						
						newCondition = condFactory.createNegativeSelectorCondition(parseSimpleSelector());
						
						// end of function
						if(currentType != CSSToken.RIGHT_BRACE)
						{
							throw createSyntaxError("Expected RIGHT_BRACE but got " + current);
						}
						
						// end negation block
						negated = false;
						
						// gobble right brace
						next();
						
						break;
						
					case Token.EOF:
						break loop;
						
					case Token.UNKNOWN:
						throw createSyntaxError("Encountered UNKNOWN token pasring simple selector condition at " + current);
					
					default:
						//trace("Breaking loop -- not a simple selector token");
						break loop;
				} // end outer switch(currentType)
				
				if(newCondition)
				{
					if(condition)
					{
						condition = condFactory.createAndCondition(condition, newCondition);
					}
					else
					{
						condition = newCondition;
					}
				}
			} // end loop:
			
			skipSpaces();
			
			if(condition)
			{
				// if a condition was found but no selector, assume * (any)
				if(!selector)
				{
					selector = selFactory.createAnyNodeSelector(ns);
				}
				
				selector = selFactory.createConditionalSelector(selector, condition);
			}
			
			return selector;
		}
		
		protected function parseNamespace():String
		{
			// check for namespace
			if(currentType == CSSToken.VERTICAL_BAR)
			{
				// explicitly NO namespace
				nextIgnoreSpaces();
				return "";
			}
			
			var nextToken:Token = look();
			var prefix:String = current.value;
			
			if(nextToken.type == CSSToken.VERTICAL_BAR)
			{
				switch(currentType)
				{
					case CSSToken.ANY:
						
						// consume * and |
						nextIgnoreSpaces();
						nextIgnoreSpaces();
						return "*";
						
					case CSSToken.IDENTIFIER:
						// look up URI
						var uri:String = namespaceDict[prefix] as String;
						
						if(!uri || !uri.length)
						{
							// no URI for this prefix, so this selector is invalid.
							// TODO: Skip invalid selectors
							throw createSyntaxError("No namespace registered with prefix \"" + prefix + "\"");
						}
						
						// consume prefix and |
						nextIgnoreSpaces();
						nextIgnoreSpaces();
						return uri;
						
					case Token.UNKNOWN:
						throw createSyntaxError("Encountered UNKNOWN token parsing namespace at " + current);
						
					default:
						// can't be a valid namespace, but our look ahead could lead us
						// to believe it was (ex: div.stub *|*:not([|title]) 
						return null;
				}
			}
			else
			{
				// no namespace found
				// TODO: Return "" or null (any or none) by default?
				return null;
			}
		}
		
		protected function parseAttributeCondition():IAttributeCondition
		{
			// attribute test
			var attribute:Token;
			var operation:Token;
			var compare:Token;
			var condition:IAttributeCondition;
			
			// From http://www.w3.org/TR/2006/REC-xml-names-20060816/#defaulting
			// A default namespace declaration applies to all unprefixed element names within its scope. 
			// Default namespace declarations do not apply directly to attribute names; the interpretation 
			// of unprefixed attributes is determined by the element on which they appear. 
			
			//check for namespace, but DON'T use the default if one isn't found
			var ns:String = parseNamespace();
			
			// attr has to be an identifier
			if(currentType != CSSToken.IDENTIFIER)
			{
				throw createSyntaxError("Expeced IDENTIFIER for attribute condition but got " + current);
			}
			
			attribute = current;
			operation = nextIgnoreSpaces();
			
			//trace("Attribute " + attribute);
			//trace("Operation switch " + operation);
			switch(operation.type)
			{
				// [attr]
				case CSSToken.RIGHT_BRACKET:
				
					condition = condFactory.createAttributeCondition(attribute.value, ns, false, null);
					// consume bracket
					next();
					//nextIgnoreSpaces();
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
					//trace("Operation value switch " + current);
					switch(currentType)
					{
						case CSSToken.STRING:
						case CSSToken.IDENTIFIER:
							
							compare = current;
							nextIgnoreSpaces();
							break;
							
						default:
							throw createSyntaxError("Expected STRING or IDENTIFIER but got " + current);
					}
					
					// ] should close the condition if all went well
					if(currentType != CSSToken.RIGHT_BRACKET)
					{
						throw createSyntaxError("Expected RIGHT_BRACKET after condition but got " + current);
					}
					
					// create condition based on type of operation
					switch(operation.type)
					{
						case CSSToken.EQUAL:
							
							condition = condFactory.createAttributeCondition(attribute.value, ns, true, compare.value);
							break;
							
						case CSSToken.INCLUDES:
							condition = condFactory.createOneOfAttributeCondition(attribute.value, ns, true, compare.value);
							break;
							
						case CSSToken.DASHMATCH:
							condition = condFactory.createBeginHyphenAttributeCondition(attribute.value, ns, true, compare.value);
							break;
							
						case CSSToken.PREFIXMATCH:
							condition = condFactory.createPrefixAttributeCondition(attribute.value, ns, true, compare.value);
							break;
							
						case CSSToken.SUFFIXMATCH:
							condition = condFactory.createSuffixAttributeCondition(attribute.value, ns, true, compare.value);
							break;
							
						case CSSToken.SUBSTRINGMATCH:
							condition = condFactory.createSubstringAttributeCondition(attribute.value, ns, true, compare.value);
							break;
					}
					
					// eat trailing bracket
					next();
					//nextIgnoreSpaces();
					break;
				
				case Token.UNKNOWN:
					throw createSyntaxError("Encountered UNKNOWN token parsing attribute condition at " + current);
			}
		
			return condition;
		}
		
		/**
		* Basic argument parsing for functional pseudo selectors
		*/
		protected function parsePseudoArguments():Array
		{
			var args:Array = new Array();
			var arg:String = "";
			
			// whitespace before and after an argument is chopped
			loop: while(true)
			{
				//trace("Argument switch " + current);
				switch(currentType)
				{
					case CSSToken.COMMA:
						
						args.push(arg);
						nextIgnoreSpaces();
						arg = "";
						break;
				
					case CSSToken.RIGHT_BRACE:
						args.push(arg);
						break loop;
						
					case Token.UNKNOWN:
						throw createSyntaxError("Encountered UNKNOWN token parsing arguments at " + current);
						
					case Token.EOF:
						throw createSyntaxError("Unexpected EOF: missing ending RIGHT_BRACE");
						
					default:						
						arg += current.value;
						next();
						break;
				}
			}
			
			return args;
		}
		
		/**
		*/
		protected function parseStyleDeclarationInternal():void
		{	
			var prop:String;
			
			loop: while(true)
			{
				switch(currentType)
				{
					case CSSToken.IDENTIFIER:
						
						if(prop)
						{
							throw createSyntaxError("Unexpected IDENTIFIER after property \"" + prop + "\" at " + current);
						}
						
						prop = current.value;
						nextIgnoreSpaces();
						
						if(currentType != CSSToken.COLON)
						{
							throw createSyntaxError("Expected COLON but got " + current);
						}
						
						// consume colon
						nextIgnoreSpaces();
						
						// parse expression following : up to ;
						var exp:ILexicalUnit = parseExpression();
						
						//trace("exp: " + exp);
						
						if(exp)
						{
							var important:Boolean = false;
							
							// !important must be the last token in the expression
							if(currentType == CSSToken.IMPORTANT_SYMBOL)
							{
								important = true;
								nextIgnoreSpaces();
							}
						
							try
							{
								docHandler.property(prop, exp, important);
							}
							catch(error:Error)
							{
								syntaxError("Error setting property value", error);
							}

							// clear out the previous property
							prop = null;
						}
						
						break;
						
					case CSSToken.RIGHT_CURLY_BRACE:
					case Token.EOF:
						return;
					
					case CSSToken.SEMI_COLON:
						prop = null;
						nextIgnoreSpaces();
						break;
						
					default:
						throw createSyntaxError("Unexpected " + current + " while parsing style declaration");
				}
			}
		}
		
		
		
		protected function parseExpression(inFunction:Boolean = false):ILexicalUnit
		{
			//trace("parseExpression(" + inFunction + ")");
			//trace("parseExpression start: " + current);

			var expression:ILexicalUnit = parseTerm();
			var result:ILexicalUnit = expression;
			
			loop: while(true)
			{
				//trace("parseExpression loop: current: " + current);
				
				var operator:Boolean = false;
				
				// operator block
				switch(currentType)
				{
					case CSSToken.COMMA:
						operator = true;
						result = new CSSLexicalUnit(LexicalUnitTypes.SAC_OPERATOR_COMMA, result);
						nextIgnoreSpaces();
						break;
						
					case CSSToken.DIVIDE:
						operator = true;
						result = new CSSLexicalUnit(LexicalUnitTypes.SAC_OPERATOR_SLASH, result);
						nextIgnoreSpaces();
						break;
						
					case Token.UNKNOWN:
						throw createSyntaxError("Encountered UNKNOWN token parsing expression at " + current);
						
					case Token.EOF:
						throw createSyntaxError("Unexpected EOF token parsing expression at " + current);
						
					default:
						break;
				}
				
				if(inFunction)
				{
					if(currentType == CSSToken.RIGHT_BRACE)
					{
						if(operator)
						{
							throw createSyntaxError("Unexpected RIGHT_BRACE after operator at " + current);
						}
						
						// end of function parameters
						break loop;
					}
					
					//trace("parseTerm function");
					result = parseTerm(result);
				}
				else
				{
					switch(currentType)
					{
						// Expression is returned at any of these ending tokens
						// If ending token is found immediately after an operator,
						// an error is thrown
						case CSSToken.IMPORTANT_SYMBOL:
						case CSSToken.SEMI_COLON:
						case CSSToken.RIGHT_CURLY_BRACE:
						case Token.EOF:
							if(operator)
							{
								throw createSyntaxError("Unexpected " + current);
							}
							
							break loop;
							
						case Token.UNKNOWN:
							throw createSyntaxError("Encountered UNKONWN token while parsing expression at " + current);
							
						default:
							result = parseTerm(result);
					}
				}
			}
			
			//trace("result: " + expression);
			
			return expression;
		}
						
		protected function parseTerm(prev:ILexicalUnit = null):ILexicalUnit
		{
			//trace("parseTerm current: " + current);
			
			var result:ILexicalUnit;
			var isNegative:Boolean = false;
			var sign:Boolean = false;
			
			switch(currentType)
			{
				case CSSToken.MINUS:
					isNegative = true;
					sign = true;
					next();
					break;
					
				case CSSToken.PLUS:
					sign = true;
					next();
					break;
					
				case Token.UNKNOWN:
					throw createSyntaxError("Encountered UNKONWN token while parsing term at " + current);
				
				default:
					isNegative = false;
					sign = false;
					break;
			}
			
			switch(currentType)
			{
				case CSSToken.NUMBER:
					result = parseNumber(isNegative, prev);
					break;
					
				case CSSToken.FUNCTION:
					result = parseFunction(isNegative, prev);
					break;
					
				case Token.UNKNOWN:
					throw createSyntaxError("Encountered UNKONWN token while parsing term at " + current);
					
				default:
					break;
			}
			
			// if we parsed a result, return it
			if(result)
			{
				return result;
			}
			
			// if we didn't complete a numeric unit but previously found a signed value, throw an error
			if(sign)
			{
				throw createSyntaxError("Error parsing signed unit");
			}
			
			switch(currentType)
			{
				case CSSToken.URI:
					result = new CSSStringUnit(LexicalUnitTypes.SAC_URI, current.value, prev);
					break;
				
				case CSSToken.STRING:
					
					result = new CSSStringUnit(LexicalUnitTypes.SAC_STRING_VALUE, current.value, prev);
					break;
					
				case CSSToken.IDENTIFIER:
				
					if(current.value.toLowerCase() == "inherit")
					{
						result = new CSSLexicalUnit(LexicalUnitTypes.SAC_INHERIT, prev);
					}
					else
					{
						result = new CSSStringUnit(LexicalUnitTypes.SAC_IDENT, current.value, prev);
					}
					
					break;
					
				case CSSToken.HEXADECIMAL:
				case CSSToken.HASH:
					result = parseHex(prev);
					break;
					
				case CSSToken.DIVIDE:
					nextIgnoreSpaces();
					result = parseTerm(prev);
					break;
					
				default:
					throw createSyntaxError("Unexpected " + current + " parsing term.");
			}
			
			nextIgnoreSpaces();
			return result;
			
		}
		
		protected function parseNumber(isNegative:Boolean = false, prev:ILexicalUnit = null):ILexicalUnit
		{
			//trace("parseNumber(" + arguments + ") current: " + current);
			
			var result:ILexicalUnit;
			
			var numVal:Number = parseFloat((isNegative ? "-" : "") + current.value);
			next();
			
			// check for dimension
			switch(currentType)
			{
				case CSSToken.SPACE:
					result = new CSSNumberUnit(LexicalUnitTypes.SAC_REAL, numVal, prev);
					break;
				case CSSToken.PERCENTAGE:
					result = new CSSDimensionUnit(LexicalUnitTypes.SAC_PERCENTAGE, numVal, prev);
					break;
				case CSSToken.PT:
					result = new CSSDimensionUnit(LexicalUnitTypes.SAC_POINT, numVal, prev);
					break;
				case CSSToken.PC:
					result = new CSSDimensionUnit(LexicalUnitTypes.SAC_PICA, numVal, prev);
					break;
				case CSSToken.PX:
					result = new CSSDimensionUnit(LexicalUnitTypes.SAC_PIXEL, numVal, prev);
					break;
				case CSSToken.CM:
					result = new CSSDimensionUnit(LexicalUnitTypes.SAC_CENTIMETER, numVal, prev);
					break;
				case CSSToken.MM:
					result = new CSSDimensionUnit(LexicalUnitTypes.SAC_MILLIMETER, numVal, prev);
					break;
				case CSSToken.IN:
					result = new CSSDimensionUnit(LexicalUnitTypes.SAC_INCH, numVal, prev);
					break;
				case CSSToken.EM:
					result = new CSSDimensionUnit(LexicalUnitTypes.SAC_EM, numVal, prev);
					break;
				case CSSToken.EX:
					result = new CSSDimensionUnit(LexicalUnitTypes.SAC_EX, numVal, prev);
					break;
				case CSSToken.DEG:
					result = new CSSDimensionUnit(LexicalUnitTypes.SAC_DEGREE, numVal, prev);
					break;
				case CSSToken.RAD:
					result = new CSSDimensionUnit(LexicalUnitTypes.SAC_RADIAN, numVal, prev);
					break;
				case CSSToken.GRAD:
					result = new CSSDimensionUnit(LexicalUnitTypes.SAC_GRADIAN, numVal, prev);
					break;
				case CSSToken.S:
					result = new CSSDimensionUnit(LexicalUnitTypes.SAC_SECOND, numVal, prev);
					break;
				case CSSToken.MS:
					result = new CSSDimensionUnit(LexicalUnitTypes.SAC_MILLISECOND, numVal, prev);
					break;
				case CSSToken.HZ:
					result = new CSSDimensionUnit(LexicalUnitTypes.SAC_HERTZ, numVal, prev);
					break;
				case CSSToken.KHZ:
					result = new CSSDimensionUnit(LexicalUnitTypes.SAC_KILOHERTZ, numVal, prev);
					break;
				case CSSToken.IDENTIFIER:
					
					var dimension:String = current.value.toLowerCase();
					
					switch(dimension)
					{
						case "pt":
							result = new CSSDimensionUnit(LexicalUnitTypes.SAC_POINT, numVal, prev);
							break;
						case "pc":
							result = new CSSDimensionUnit(LexicalUnitTypes.SAC_PICA, numVal, prev);
							break;
						case "px":
							result = new CSSDimensionUnit(LexicalUnitTypes.SAC_PIXEL, numVal, prev);
							break;
						case "cm":
							result = new CSSDimensionUnit(LexicalUnitTypes.SAC_CENTIMETER, numVal, prev);
							break;
						case "mm":
							result = new CSSDimensionUnit(LexicalUnitTypes.SAC_MILLIMETER, numVal, prev);
							break;
						case "in":
							result = new CSSDimensionUnit(LexicalUnitTypes.SAC_INCH, numVal, prev);
							break;
						case "em":
							result = new CSSDimensionUnit(LexicalUnitTypes.SAC_EM, numVal, prev);
							break;
						case "ex":
							result = new CSSDimensionUnit(LexicalUnitTypes.SAC_EX, numVal, prev);
							break;
						case "deg":
							result = new CSSDimensionUnit(LexicalUnitTypes.SAC_DEGREE, numVal, prev);
							break;
						case "rad":
							result = new CSSDimensionUnit(LexicalUnitTypes.SAC_RADIAN, numVal, prev);
							break;
						case "grad":
							result = new CSSDimensionUnit(LexicalUnitTypes.SAC_GRADIAN, numVal, prev);
							break;
						case "s":
							result = new CSSDimensionUnit(LexicalUnitTypes.SAC_SECOND, numVal, prev);
							break;
						case "ms":
							result = new CSSDimensionUnit(LexicalUnitTypes.SAC_MILLISECOND, numVal, prev);
							break;
						case "hz":
							result = new CSSDimensionUnit(LexicalUnitTypes.SAC_HERTZ, numVal, prev);
							break;
						case "khz":
							result = new CSSDimensionUnit(LexicalUnitTypes.SAC_KILOHERTZ, numVal, prev);
							break;
						default:
							result = new CSSDimensionUnit(LexicalUnitTypes.SAC_DIMENSION, numVal, prev);
							break;
					}
					
					break;
					
				default:
					break;
			}
			
			if(result)
			{
				nextIgnoreSpaces();
			}
			else
			{
				result = new CSSNumberUnit(LexicalUnitTypes.SAC_REAL, numVal, prev);
			}
			
			return result;
		}
		
		protected function parseHex(prev:ILexicalUnit = null):ILexicalUnit
		{
			var result:ILexicalUnit = prev;
			var hex:String = current.value;
			
			// get everything after the # if there is one
			hex = hex.substr(hex.indexOf("#") + 1);
			
			var len:int = hex.length;
			
			switch(len)
			{
				case 3:
					// #abc to #aabbcc
					hex = hex.charAt(0) + hex.charAt(0) + hex.charAt(1) + hex.charAt(1) + hex.charAt(2) + hex.charAt(2);
					break;
					
				case 6:
					break;
					
				default:
					throw createSyntaxError("Hex color values must be 3 or 6 characters long.");
			}
			
			var red:int = parseInt(hex.charAt(0) + hex.charAt(1), 16);
			var green:int = parseInt(hex.charAt(2) + hex.charAt(3), 16);
			var blue:int = parseInt(hex.charAt(4) + hex.charAt(5), 16);
			
			var params:ILexicalUnit = new CSSNumberUnit(LexicalUnitTypes.SAC_INTEGER, red);
			var param:ILexicalUnit = params;
			param = new CSSLexicalUnit(LexicalUnitTypes.SAC_OPERATOR_COMMA, param);
			param = new CSSNumberUnit(LexicalUnitTypes.SAC_INTEGER, green, param);
			param = new CSSLexicalUnit(LexicalUnitTypes.SAC_OPERATOR_COMMA, param);
			param = new CSSNumberUnit(LexicalUnitTypes.SAC_INTEGER, blue, param);
			
			return new CSSFunctionLexicalUnit(LexicalUnitTypes.SAC_RGBCOLOR, "rgb", params, result);
		}
		
		protected function parseFunction(isNegative:Boolean = false, prev:ILexicalUnit = null):ILexicalUnit
		{
			//trace("parseFunction(): " + arguments);
			
			var result:ILexicalUnit = prev;
			
			// gobble up function name
			var funcName:String = current.value;
			nextIgnoreSpaces();
			
			var params:ILexicalUnit = parseExpression(true);
			
			// check for parenthesis close
			if(currentType != CSSToken.RIGHT_BRACE)
			{
				throw createSyntaxError("Expected RIGHT_BRACE but got " + current);
			}
			
			// consume right paren ")"
			nextIgnoreSpaces();
			
			switch(funcName.toLowerCase())
			{
				case "rgb":
					result = new CSSFunctionLexicalUnit(LexicalUnitTypes.SAC_RGBCOLOR, funcName, params, result);
					break;
					
				case "rgba":
					result = new CSSFunctionLexicalUnit(LexicalUnitTypes.SAC_RGBACOLOR, funcName, params, result);
					break;
					
				case "hsl":
					result = new CSSFunctionLexicalUnit(LexicalUnitTypes.SAC_HSLCOLOR, funcName, params, result);
					break;
					
				case "hsla":
					result = new CSSFunctionLexicalUnit(LexicalUnitTypes.SAC_HSLACOLOR, funcName, params, result);
					break;
				
				case "rect":
					result = new CSSFunctionLexicalUnit(LexicalUnitTypes.SAC_RECT_FUNCTION, funcName, params, result);
					break;
				
				case "attr":
					result = new CSSFunctionLexicalUnit(LexicalUnitTypes.SAC_ATTR, funcName, params, result);
					break;
					
				case "counter":
					result = new CSSFunctionLexicalUnit(LexicalUnitTypes.SAC_COUNTER_FUNCTION, funcName, params, result);
					break;
					
				case "counters":
					result = new CSSFunctionLexicalUnit(LexicalUnitTypes.SAC_COUNTERS_FUNCTION, funcName, params, result);
					break;
					
				default:
					result = new CSSFunctionLexicalUnit(LexicalUnitTypes.SAC_FUNCTION, funcName, params, result);
					break;
			}
			
			return result;
		}
		
		protected function recover():void
		{
			var cbraces:int = 0;
			
			while(true)
			{
				switch(currentType)
				{
					case Token.EOF:
						return;
					case CSSToken.SEMI_COLON:
						
						if(cbraces == 0)
		            	{
		            		nextIgnoreSpaces();
		            		return;
		            	}
		            	
		            	break;
		            
		            case CSSToken.RIGHT_CURLY_BRACE:
		            
		            	if(--cbraces <= 0)
		            	{
		            		nextIgnoreSpaces();
		            		return;
		            	}
		            	
		            	break;
		            	
		            case CSSToken.LEFT_CURLY_BRACE:
		            	cbraces++;
		            	break;
				}
				
				nextIgnoreSpaces();
			}
		}
		
		protected function cleanup():void
		{
			negated = false;
			pseudoElement = null;
			tokenizer = null;
			current = null;
			namespaceDict = new Dictionary();
			defaultNamespace = null;
		}
		
		protected function createTokenizer(source:String):Tokenizer
		{
			return new CSSTokenizer(source);
		}
		
		protected function syntaxError(message:String, internalError:Error = null):void
		{
			reportError(message, CSSErrorTypes.SAC_SYNTAX_ERR, internalError);
			
			//trace("recover() starting at " + current);
			recover();
			//trace("recover() ending at " + current);
		}
		
		protected function reportWarning(message:String, code:int = 0, internalError:Error = null):void
		{
			var warning:CSSParseError = createParseError(message, code, internalError);
			errHandler.warning(warning);
		}
		
		protected function reportError(message:String, code:int = 0, internalError:Error = null):void
		{
			var error:CSSParseError = createParseError(message, code, internalError);
			errHandler.error(error);
		}
		
		protected function reportFatal(message:String, code:int = 0, internalError:Error = null):void
		{
			var error:CSSParseError = createParseError(message, CSSErrorTypes.SAC_UNSPECIFIED_ERR, internalError);
			errHandler.fatalError(error);
		}
		
		protected function createSyntaxError(message:String, internalError:Error = null):CSSParseError
		{
			// tmp
			if(internalError) trace(internalError.getStackTrace());
			
			return createParseError(message, CSSErrorTypes.SAC_SYNTAX_ERR, internalError);
		}
		
		protected function createParseError(message:String, code:int = 0, internalError:Error = null):CSSParseError
		{
			return new CSSParseError(message, code, tokenizer.line, tokenizer.column, null, internalError);
		}
	}
}