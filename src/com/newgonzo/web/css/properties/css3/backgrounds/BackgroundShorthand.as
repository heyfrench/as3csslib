package com.newgonzo.web.css.properties.css3.backgrounds
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.ICSSStyleMap;
	import com.newgonzo.web.css.parser.LexicalUnitStream;
	import com.newgonzo.web.css.properties.IPropertyManager;
	import com.newgonzo.web.css.properties.IShorthandManager;
	import com.newgonzo.web.css.properties.PropertyManager;
	
	import org.w3c.css.sac.ILexicalUnit;
	import org.w3c.css.sac.LexicalUnitTypes;
	
	public class BackgroundShorthand extends PropertyManager implements IShorthandManager
	{
		protected static const LONGHAND_PROPERTIES:Array =
		[
			BackgroundProperties.BACKGROUND_COLOR,
			BackgroundProperties.BACKGROUND_IMAGE,
			BackgroundProperties.BACKGROUND_POSITION,
			BackgroundProperties.BACKGROUND_SIZE,
			BackgroundProperties.BACKGROUND_REPEAT,
			BackgroundProperties.BACKGROUND_ATTACHMENT,
			BackgroundProperties.BACKGROUND_ORIGIN
		];
		
		public function BackgroundShorthand()
		{
			super(BackgroundProperties.BACKGROUND);
		}
		
		public function get longhandProperties():Array
		{
			return LONGHAND_PROPERTIES;
		}
		
		override public function setValues(document:ICSSDocument, styleMap:ICSSStyleMap, lexicalUnitStream:LexicalUnitStream, priority:String = null, inShorthand:Boolean = false):void
		{
			var propName:String;
			var manager:IPropertyManager;
			
			var matchedProps:Object = createMatchedPropertyHash();
			var value:ILexicalUnit = lexicalUnitStream.current;
			var valueMatched:Boolean = false;
			
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
					
					// If ‘background-origin’ is present and its value matches a possible value 
					// for ‘background-clip’ then it also sets ‘background-clip’ to that value.
					if(propName == BackgroundProperties.BACKGROUND_ORIGIN)
					{
						manager = document.context.getPropertyManager(BackgroundProperties.BACKGROUND_CLIP);
						
						if(manager.acceptsValue(value))
						{
							// re-position stream
							lexicalUnitStream.current = value;
							manager.setValues(document, styleMap, lexicalUnitStream, priority, true);
						}
					}
					
					// new value is position 
					value = lexicalUnitStream.current;
					
					if(value && value.type == LexicalUnitTypes.SAC_OPERATOR_SLASH)
					{
						// skip slash
						value = lexicalUnitStream.next();
						
						propName = BackgroundProperties.BACKGROUND_SIZE;
						
						// bg-size must not have been matched already
						if(matchedProps[propName])
						{
							throw createSyntaxError("background-size has already been matched.");
						}
						
						manager = document.context.getPropertyManager(propName);
						
						if(manager.acceptsValue(value))
						{
							manager.setValues(document, styleMap, lexicalUnitStream, priority, true);
							
							// matched prop
							matchedProps[propName] = true;
							
							// bg-position must occur before bg-size if both are present
							//matchedProps[BackgroundProperties.BACKGROUND_POSITION] = true;
							
							// value matched, next value
							value = lexicalUnitStream.current;
						}
					}
					
					// break inner loop if we made a match
					valueMatched = true;
					break;
				}
				
				// if we make it past the inner loop it means we've checked
				// all of the properties and found no match. At this point, throw an error
				if(value && !valueMatched)
				{
					throw createSyntaxError("No match found for " + value + " in background shorthand.");
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