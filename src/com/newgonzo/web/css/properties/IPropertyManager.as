package com.newgonzo.web.css.properties
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.ICSSStyleMap;
	import com.newgonzo.web.css.parser.LexicalUnitStream;
	import com.newgonzo.web.css.values.IValue;
	
	import org.w3c.css.sac.ILexicalUnit;
	
	public interface IPropertyManager
	{
		function get propertyName():String
		function get defaultValue():IValue
		function get isInherited():Boolean
		function get isAnimatable():Boolean

		//function createValue(unit:ILexicalUnit):IValue
		//function computeValue(node:*, pseudo:String, document:ICSSDocument, style:ICSSStyleMap, value:IValue):IValue

		function acceptsValue(propertyValue:ILexicalUnit):Boolean
		function setValues(document:ICSSDocument, styleMap:ICSSStyleMap, lexicalUnitStream:LexicalUnitStream, priority:String = null, inShorthand:Boolean = false):void//ILexicalUnit
	}
}