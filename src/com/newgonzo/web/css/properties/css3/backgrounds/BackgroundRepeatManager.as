package com.newgonzo.web.css.properties.css3.backgrounds
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.ICSSStyleMap;
	import com.newgonzo.web.css.parser.LexicalUnitStream;
	import com.newgonzo.web.css.properties.IdentifierManager;
	import com.newgonzo.web.css.values.PairValue;
	import com.newgonzo.web.css.values.css3.CSS3Values;
	
	import org.w3c.css.sac.ILexicalUnit;

	public class BackgroundRepeatManager extends IdentifierManager
	{
		protected static const VALID_IDENTIFIERS:Array = 
		[
			CSS3Values.REPEAT,
			CSS3Values.REPEAT_X,
			CSS3Values.REPEAT_Y,
			CSS3Values.NO_REPEAT,
			CSS3Values.SPACE,
			CSS3Values.ROUND
		];
		
		public function BackgroundRepeatManager()
		{
			super(BackgroundProperties.BACKGROUND_REPEAT, CSS3Values.REPEAT_VALUE, false, VALID_IDENTIFIERS);
		}
		
		override public function setValues(document:ICSSDocument, styleMap:ICSSStyleMap, lexicalUnitStream:LexicalUnitStream, priority:String = null, inShorthand:Boolean = false):void
		{
			/* from http://www.w3.org/TR/css3-background/#ltrepeat-stylegt
			‘repeat-x’
			    Equivalent to ‘repeat no-repeat’. 
			‘repeat-y’
			    Equivalent to ‘no-repeat repeat’. 
			‘repeat’
			    Equivalent to ‘repeat repeat’. 
			‘no-repeat’
			    Equivalent to ‘no-repeat no-repeat’ 
			‘space’
			    Equivalent to ‘space space’ 
			‘round’
			    Equivalent to ‘round round’ 
			*/
			
			var lexicalUnit:ILexicalUnit = lexicalUnitStream.current;
			
			var ident1:String = lexicalUnit.stringValue;
			var ident2:String;
			
			lexicalUnit = lexicalUnitStream.next();
			
			if(lexicalUnit && super.acceptsValue(lexicalUnit))
			{
				ident2 = lexicalUnit.stringValue;
				lexicalUnitStream.next();
			}
			
			if(!ident2)
			{
				switch(ident1)
				{
					case CSS3Values.REPEAT_X:
						ident1 = CSS3Values.REPEAT;
						ident2 = CSS3Values.NO_REPEAT;
						break;
					case CSS3Values.REPEAT_Y:
						ident2 = CSS3Values.REPEAT;
						ident1 = CSS3Values.NO_REPEAT;
						break;
					default:
						ident2 = ident1;
						break;
				}
			}
			else
			{
				if(ident1 == CSS3Values.REPEAT_X || ident1 == CSS3Values.REPEAT_Y)
				{
					throw createSyntaxError("Unexpected " + ident2 + " after " + ident1);
				}
			}
			
			styleMap.setProperty(propName, new PairValue(CSS3Values.getIdentifier(ident1), CSS3Values.getIdentifier(ident2)), priority);
		}
	}
}