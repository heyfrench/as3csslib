package com.newgonzo.web.css.properties.css3.backgrounds
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.ICSSStyleMap;
	import com.newgonzo.web.css.parser.LexicalUnitStream;
	import com.newgonzo.web.css.properties.LengthManager;
	import com.newgonzo.web.css.values.PairValue;
	import com.newgonzo.web.css.values.css3.CSS3Values;
	
	import org.w3c.css.sac.ILexicalUnit;
	import org.w3c.css.sac.LexicalUnitTypes;
	import org.w3c.dom.css.ICSSValue;

	public class BackgroundPositionManager extends LengthManager
	{
		protected static const VALID_IDENTIFIERS:Array = 
		[
			CSS3Values.TOP,
			CSS3Values.RIGHT,
			CSS3Values.BOTTOM,
			CSS3Values.LEFT,
			CSS3Values.CENTER
		];
		
		public function BackgroundPositionManager()
		{
			super(BackgroundProperties.BACKGROUND_POSITION, null, false, VALID_IDENTIFIERS);
		}
		
		override public function setValues(document:ICSSDocument, styleMap:ICSSStyleMap, lexicalUnitStream:LexicalUnitStream, priority:String = null, inShorthand:Boolean = false):void
		{
			/* From http://www.w3.org/TR/2009/CR-css3-background-20091217/#ltbg-positiongt
			 
			 background-position is
			 [
			  [ [ <percentage> | <length> | left | center | right ] ]
			  [ [ <percentage> | <length> | top | center | bottom ] ]?
			|
			  [ center | [ left | right ] [ <percentage> | <length> ]? ] ||
			  [ center | [ top | bottom ] [ <percentage> | <length> ]? ]
			]
			
			 background-position: left 10px top 15px;   /* 10px, 15px /
			 background-position: left      top     ;   /*  0px,  0px /
			 background-position:      10px     15px;   /* 10px, 15px /
			 background-position: left          15px;   /*  0px, 15px /
			 background-position:      10px top     ;   /* 10px,  0px /
			 background-position: left      top 15px;   /*  0px, 15px /
			 background-position: left 10px top     ;   /* 10px,  0px /
			
			*/
			
			var lexicalUnit:ILexicalUnit = lexicalUnitStream.current;
			var xyPair:PairValue;
			
			var firstPair:PairValue;
			var secondPair:PairValue;
			
			var value1:ICSSValue;
			var value2:ICSSValue;
			
			var foundX:Boolean = false;
			var foundY:Boolean = false;
			
			if(lexicalUnit.stringValue == CSS3Values.CENTER)
			{
				// ambiguous
				value1 = CSS3Values.PERCENTAGE_50_VALUE;
				// consume center
				lexicalUnit = lexicalUnitStream.next();
			}
			else if(lexicalUnit.type == LexicalUnitTypes.SAC_IDENT)
			{
				// left || right || top || bottom
				firstPair = parseXYPair(document, lexicalUnitStream);
				
				if(firstPair)
				{
					foundX = isXValue(firstPair.first);
					foundY = isYValue(firstPair.first);
				}
				
				// where parseXYPair left off
				lexicalUnit = lexicalUnitStream.current;
			}
			else if(acceptsValue(lexicalUnit))
			{
				// ambiguous length
				value1 = document.context.factory.createValue(lexicalUnit);
				// consume accepted value
				lexicalUnit = lexicalUnitStream.next();
			}
			else
			{
				throw createSyntaxError("Unexpected " + lexicalUnit + " in background-position");
			}
			
			
			if(lexicalUnit)
			{
				if(lexicalUnit.stringValue == CSS3Values.CENTER)
				{
					// ambiguous
					value2 = CSS3Values.PERCENTAGE_50_VALUE;
					
					// consume center
					lexicalUnit = lexicalUnitStream.next();
				}
				else if(lexicalUnit.type == LexicalUnitTypes.SAC_IDENT)
				{
					// left || right || top || bottom
					secondPair = parseXYPair(document, lexicalUnitStream);
					
					if(secondPair)
					{
						// throw an error if there are two explicit
						// definitions for either axis
						if(isYValue(secondPair.first))
						{
							if(foundY)
							{
								throw createSyntaxError("Duplicate definition of background-position Y-axis value");
							}
							
							foundY = true;
						}
						else if(isXValue(secondPair.first))
						{
							if(foundX)
							{
								throw createSyntaxError("Duplicate definition of background-position X-axis value");
							}
							
							foundX = true;
						}
					}
				}
				else if(acceptsValue(lexicalUnit))
				{
					// ambiguous length
					value2 = document.context.factory.createValue(lexicalUnit);
					
					// consume accepted value
					lexicalUnit = lexicalUnitStream.next();
				}
			}
			else
			{
				// no second value
				value2 = CSS3Values.PERCENTAGE_0_VALUE ;
			}
			
			// clean up
			if(!firstPair)
			{
				if(foundX)
				{
					firstPair = new PairValue(CSS3Values.TOP_VALUE, value1);
					foundY = true;
				}
				else
				{
					firstPair = new PairValue(CSS3Values.LEFT_VALUE, value1);
					foundX = true;
				}
			}
			
			if(!secondPair)
			{
				if(foundY)
				{
					secondPair = new PairValue(CSS3Values.LEFT_VALUE, value2);
					foundX = true;
				}
				else
				{
					secondPair = new PairValue(CSS3Values.TOP_VALUE, value2);
					foundY = true;
				}
			}
			
			if(isXValue(firstPair.first))
			{
				xyPair = new PairValue(firstPair, secondPair);
			}
			else
			{
				// swap
				xyPair = new PairValue(secondPair, firstPair);
			}
			
			styleMap.setProperty(propName, xyPair, priority);
		}
		
		protected function parseXYPair(document:ICSSDocument, stream:LexicalUnitStream):PairValue
		{
			var val1:ICSSValue;
			var val2:ICSSValue;
			var lex:ILexicalUnit = stream.current;
			var ident:String = lex.stringValue;
			
			switch(ident)
			{
				case CSS3Values.LEFT:
					val1 = CSS3Values.LEFT_VALUE;
					break;
					
				case CSS3Values.RIGHT:
					val1 = CSS3Values.RIGHT_VALUE;
					break;
					
				case CSS3Values.TOP:
					val1 = CSS3Values.TOP_VALUE;
					break;
					
				case CSS3Values.BOTTOM:
					val1 = CSS3Values.BOTTOM_VALUE;
					break;
				default:
					return null;
			}
			
			lex = stream.next();
			
			if(lex && lex.type != LexicalUnitTypes.SAC_IDENT && super.acceptsValue(lex))
			{
				// length percentage or value
				val2 = document.context.factory.createValue(lex);
				
				// consume value
				stream.next();
			}
			else
			{
				// 0 by default
				val2 = CSS3Values.PERCENTAGE_0_VALUE;
			}
			
			return new PairValue(val1, val2);
		}
		
		protected function isXValue(value:ICSSValue):Boolean
		{
			return value == CSS3Values.LEFT_VALUE || value == CSS3Values.RIGHT_VALUE;
		}
		
		protected function isYValue(value:ICSSValue):Boolean
		{
			return value == CSS3Values.TOP_VALUE || value == CSS3Values.BOTTOM_VALUE;
		}
	}
}