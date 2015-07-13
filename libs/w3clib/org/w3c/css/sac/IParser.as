package org.w3c.css.sac
{
	public interface IParser
	{
		function get parserVersion():String
		
		function parsePriority(input:String):Boolean
		function parsePropertyValue(input:String):ILexicalUnit
		function parseRule(input:String):void
		function parseSelectors(input:String):ISelectorList
		function parseStyleDeclaration(input:String):void
		function parseStyleSheet(input:String):void
		
		function set conditionFactory(value:IConditionFactory):void
		function get conditionFactory():IConditionFactory
		
		function set selectorFactory(value:ISelectorFactory):void
		function get selectorFactory():ISelectorFactory
		
		function set documentHandler(value:IDocumentHandler):void
		function get documentHandler():IDocumentHandler
		
		function set errorHandler(value:IErrorHandler):void
		function get errorHandler():IErrorHandler
	}
}
