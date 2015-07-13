package com.newgonzo.web.css.properties.css3.borders
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.ICSSStyleMap;
	import com.newgonzo.web.css.parser.LexicalUnitStream;
	import com.newgonzo.web.css.properties.IShorthandManager;
	import com.newgonzo.web.css.properties.LengthManager;
	
	import com.newgonzo.web.css.values.css3.CSS3Values;

	public class BorderRadiusShorthand extends LengthManager implements IShorthandManager
	{
		protected static const LONGHAND_PROPERTIES:Array =
		[
			BorderProperties.BORDER_TOP_LEFT_RADIUS,
			BorderProperties.BORDER_TOP_RIGHT_RADIUS,
			BorderProperties.BORDER_BOTTOM_RIGHT_RADIUS,
			BorderProperties.BORDER_BOTTOM_LEFT_RADIUS
		];
		
		public function BorderRadiusShorthand()
		{
			super(BorderProperties.BORDER_RADIUS, CSS3Values.ZERO_VALUE, false);
		}
		
		public function get longhandProperties():Array
		{
			return LONGHAND_PROPERTIES;
		}
		
		override public function setValues(document:ICSSDocument, styleMap:ICSSStyleMap, lexicalUnitStream:LexicalUnitStream, priority:String = null, inShorthand:Boolean = false):void
		{
			setTopRightBottomLeftValues(document, styleMap, LONGHAND_PROPERTIES, lexicalUnitStream, priority);
		}
	}
}