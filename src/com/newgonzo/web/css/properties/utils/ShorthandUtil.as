package com.newgonzo.web.css.properties.utils
{
	import com.newgonzo.web.css.parser.LexicalUnitStream;
	import com.newgonzo.web.css.properties.IPropertyManager;
	
	import org.w3c.css.sac.CSSError;
	import org.w3c.css.sac.CSSErrorTypes;
	import org.w3c.css.sac.ILexicalUnit;
	
	public class ShorthandUtil
	{
		public static function createPropertyNameHash(propertyNames:Array):Object
		{
			var hash:Object = {};
			var prop:String;
			
			for each(prop in propertyNames)
			{
				hash[prop] = null;
			}
			
			return hash;
		}
		
		public static function createTopRightBottomLeftValues(shorthandManager:IPropertyManager, lexicalUnitStream:LexicalUnitStream):Array
		{
			var expandedValues:Array = new Array();
			var lexicalUnit:ILexicalUnit = lexicalUnitStream.current;
			
			while(lexicalUnit && shorthandManager.acceptsValue(lexicalUnit))
			{
				expandedValues.push(lexicalUnit);
				lexicalUnit = lexicalUnitStream.next();
			}
			
			var count:int = expandedValues.length;
			
			switch(count)
			{
				case 1:
					expandedValues[3] = expandedValues[2] = expandedValues[1] = expandedValues[0];
					break;
				case 2:
					expandedValues[2] = expandedValues[0];
					expandedValues[3] = expandedValues[1];
					break;
				case 3:
					expandedValues[3] = expandedValues[1];
					break;
				case 4:
					break;
					
				default:
					throw new CSSError("Expected 1-4 values for top-right-bottom-left property, found " + count, CSSErrorTypes.SAC_SYNTAX_ERR);
			}
			
			return expandedValues;
		}
	}
}