package com.newgonzo.web.css.properties.css3.fonts
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.ICSSStyleMap;
	import com.newgonzo.web.css.parser.LexicalUnitStream;
	import com.newgonzo.web.css.properties.IPropertyManager;
	import com.newgonzo.web.css.properties.IShorthandManager;
	import com.newgonzo.web.css.properties.IdentifierManager;
	import com.newgonzo.web.css.values.css3.CSS3Values;
	
	import org.w3c.css.sac.ILexicalUnit;
	import org.w3c.css.sac.LexicalUnitTypes;
	import org.w3c.dom.css.ICSSValue;

	public class FontShorthand extends IdentifierManager implements IShorthandManager
	{
		protected static const VALID_IDENTIFIERS:Array = 
		[
			CSS3Values.CAPTION,
			CSS3Values.ICON,
			CSS3Values.MENU,
			CSS3Values.MESSAGE_BOX,
			CSS3Values.SMALL_CAPTION,
			CSS3Values.STATUS_BAR
		];
		
		protected static const LONGHAND_PROPERTIES:Array =
		[
			FontProperties.FONT_STYLE, 
			FontProperties.FONT_VARIANT, 
			FontProperties.FONT_WEIGHT, 
			FontProperties.FONT_SIZE, 
			FontProperties.LINE_HEIGHT, 
			FontProperties.FONT_FAMILY
		];
		
		public function FontShorthand()
		{
			super(FontProperties.FONT, null, true, VALID_IDENTIFIERS);
		}
		
		public function get longhandProperties():Array
		{
			return LONGHAND_PROPERTIES;
		}
		
		override public function setValues(document:ICSSDocument, styleMap:ICSSStyleMap, lexicalUnitStream:LexicalUnitStream, priority:String = null, inShorthand:Boolean = false):void
		{
			//http://www.w3.org/TR/css3-fonts/#shorthand-font-property-the-font-propert
			// 	[ [ <‘font-style’> || <‘font-variant’> || <‘font-weight’> ]? <‘font-size’> [ / <‘line-height’> ]? <‘font-family’> ] | caption | icon | menu | message-box | small-caption | status-bar | inherit 
			
			var propName:String;
			var manager:IPropertyManager;
			
			var matchedProps:Object = createMatchedPropertyHash();
			var value:ILexicalUnit = lexicalUnitStream.current;
			var valueMatched:Boolean = false;
			
			// check the identifier list first for inherit|caption|icon|etc values
			if(super.acceptsValue(value))
			{
				var cssValue:ICSSValue = document.context.factory.createValue(value);
				
				// set for all properties
				for each(propName in LONGHAND_PROPERTIES)
				{
					//manager = document.context.getPropertyManager(propName);
					//manager.setValues(document, styleMap, propertyValue, priority);
					styleMap.setProperty(propName, cssValue, priority);
				}
				
				return;
			}
			
			
			outer: while(value)
			{
				valueMatched = false;
				
				for each(propName in LONGHAND_PROPERTIES)
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
					
					// new value is position 
					value = lexicalUnitStream.current;
					
					if(value && value.type == LexicalUnitTypes.SAC_OPERATOR_SLASH)
					{
						// skip slash
						value = lexicalUnitStream.next();
						
						propName = FontProperties.LINE_HEIGHT;
						
						// line-height must not have been matched already
						if(matchedProps[propName])
						{
							throw createSyntaxError("line-height has already been matched.");
						}
						
						manager = document.context.getPropertyManager(propName);
						
						if(!manager.acceptsValue(value))
						{
							throw createSyntaxError("line-height doesn't accept value " + value);
						}
						
						manager.setValues(document, styleMap, lexicalUnitStream, priority, true);
						
						// matched prop
						matchedProps[propName] = true;
						
						// value matched, next value
						value = lexicalUnitStream.current;
					}
					
					// break inner loop if we made a match
					valueMatched = true;
					break;
				}
				
				// if we make it past the inner loop it means we've checked
				// all of the properties and found no match. At this point, throw an error
				if(value && !valueMatched)
				{
					throw createSyntaxError("No match found for " + value + " in font shorthand.");
				}
			}
		}
		
		private function createMatchedPropertyHash():Object
		{
			var hash:Object = {};
			var prop:String;
			
			for each(prop in LONGHAND_PROPERTIES)
			{
				hash[prop] = false;
			}
			
			return hash;
		}
	}
}