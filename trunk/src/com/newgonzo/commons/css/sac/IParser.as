package com.newgonzo.commons.css.sac
{
	public interface IParser
	{
		function parse(source:String):void
		function parseSelectors(selectors:String):ISelectorList
		function set documentHandler(handler:IDocumentHandler):void
		function set selectorFactory(value:ISelectorFactory):void
		function set conditionFactory(value:IConditionFactory):void
	}
}