package com.newgonzo.web.css.properties.css3.borders
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.ICSSStyleMap;
	import com.newgonzo.web.css.parser.LexicalUnitStream;
	import com.newgonzo.web.css.properties.IPropertyManager;
	import com.newgonzo.web.css.properties.IShorthandManager;
	import com.newgonzo.web.css.properties.PropertyManager;
	
	import com.newgonzo.web.css.properties.utils.ShorthandUtil;
	
	import org.w3c.css.sac.ILexicalUnit;
	
	public class BorderSideShorthand extends PropertyManager implements IShorthandManager
	{
		protected static const LONGHAND_PROPERTIES:Object = {};
		
		LONGHAND_PROPERTIES[BorderProperties.BORDER_TOP] =
		[
			BorderProperties.BORDER_TOP_WIDTH,
			BorderProperties.BORDER_TOP_STYLE,
			BorderProperties.BORDER_TOP_COLOR
		];
		
		LONGHAND_PROPERTIES[BorderProperties.BORDER_RIGHT] =
		[
			BorderProperties.BORDER_RIGHT_WIDTH,
			BorderProperties.BORDER_RIGHT_STYLE,
			BorderProperties.BORDER_RIGHT_COLOR
		];
		
		LONGHAND_PROPERTIES[BorderProperties.BORDER_BOTTOM] =
		[
			BorderProperties.BORDER_BOTTOM_WIDTH,
			BorderProperties.BORDER_BOTTOM_STYLE,
			BorderProperties.BORDER_BOTTOM_COLOR
		];
		
		LONGHAND_PROPERTIES[BorderProperties.BORDER_LEFT] =
		[
			BorderProperties.BORDER_LEFT_WIDTH,
			BorderProperties.BORDER_LEFT_STYLE,
			BorderProperties.BORDER_LEFT_COLOR
		];
		
		public function BorderSideShorthand(propertyName:String)
		{
			super(propertyName);
		}
		
		public function get longhandProperties():Array
		{
			return LONGHAND_PROPERTIES[propName] as Array;
		}
		
		override public function setValues(document:ICSSDocument, styleMap:ICSSStyleMap, lexicalUnitStream:LexicalUnitStream, priority:String = null, inShorthand:Boolean = false):void
		{
			var propName:String;
			var manager:IPropertyManager;
			
			var longhand:Array = longhandProperties;
			
			var matchedProps:Object = ShorthandUtil.createPropertyNameHash(longhand);
			var value:ILexicalUnit = lexicalUnitStream.current;
			var valueMatched:Boolean = false;
			
			outer: while(value)
			{
				valueMatched = false;
				
				for each(propName in longhand)
				{
					// skip if already matched
					if(matchedProps[propName])
					{
						continue;
					}
					
					manager = document.context.getPropertyManager(propName);
					
					if(!manager.acceptsValue(value))
					{
						continue;
					}
					
					manager.setValues(document, styleMap, lexicalUnitStream, priority, true);
					
					// prop matched
					matchedProps[propName] = true;
					
					// update current value
					value = lexicalUnitStream.current;
					
					// break inner loop if we made a match
					valueMatched = true;
					break;
				}
				
				// if we make it past the inner loop it means we've checked
				// all of the properties and found no match. At this point, throw an error
				if(value && !valueMatched)
				{
					throw createSyntaxError("No match found for " + value + " in " + propName + " shorthand.");
				}
			}
		}
	}
}