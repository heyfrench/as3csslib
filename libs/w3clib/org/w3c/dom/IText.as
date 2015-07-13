package org.w3c.dom
{
	public interface IText extends ICharacterData
	{
		function splitText(offset:int):IText
		
		function get isElementContentWhitespace():Boolean
		function get wholeText():String
		function replaceWholeText(content:String):IText
	}
}