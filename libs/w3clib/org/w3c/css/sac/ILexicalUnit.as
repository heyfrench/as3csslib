package org.w3c.css.sac
{
	public interface ILexicalUnit
	{
		function get type():uint
		function get dimensionalUnitText():String
		function get functionName():String
		
		function get nextLexicalUnit():ILexicalUnit
		function get previousLexicalUnit():ILexicalUnit
		
		function get parameters():ILexicalUnit
		function get subValues():ILexicalUnit
		
		function get stringValue():String
		function get floatValue():Number
		function get integerValue():int
	}
}