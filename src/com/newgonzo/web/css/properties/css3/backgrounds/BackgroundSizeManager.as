package com.newgonzo.web.css.properties.css3.backgrounds
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.ICSSStyleMap;
	import com.newgonzo.web.css.parser.LexicalUnitStream;
	import com.newgonzo.web.css.properties.LengthManager;
	import com.newgonzo.web.css.values.PairValue;
	import com.newgonzo.web.css.values.css3.CSS3Values;
	
	import org.w3c.css.sac.ILexicalUnit;
	import org.w3c.dom.css.ICSSValue;
	
	public class BackgroundSizeManager extends LengthManager
	{
		protected static const VALID_IDENTIFIERS:Array = 
		[
			CSS3Values.AUTO,
			CSS3Values.CONTAIN,
			CSS3Values.COVER
		];
		
		public function BackgroundSizeManager()
		{
			super(BackgroundProperties.BACKGROUND_SIZE, CSS3Values.AUTO_VALUE, false, VALID_IDENTIFIERS);
		}
		
		override public function setValues(document:ICSSDocument, styleMap:ICSSStyleMap, lexicalUnitStream:LexicalUnitStream, priority:String = null, inShorthand:Boolean = false):void
		{
			var lexicalUnit:ILexicalUnit = lexicalUnitStream.current;
			var value1:ICSSValue = document.context.factory.createValue(lexicalUnit);
			var value2:ICSSValue;
			
			lexicalUnit = lexicalUnitStream.next();
			
			if(lexicalUnit && super.acceptsValue(lexicalUnit))
			{
				value2 = document.context.factory.createValue(lexicalUnit);
				lexicalUnitStream.next();
			}
			else
			{
				value2 = value1;
			}
			
			var pair:PairValue = new PairValue(value1, value2);
			styleMap.setProperty(propertyName, pair, priority);
		}
	}
}