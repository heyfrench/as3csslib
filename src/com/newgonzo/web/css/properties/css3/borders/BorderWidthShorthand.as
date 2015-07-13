package com.newgonzo.web.css.properties.css3.borders
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.ICSSStyleMap;
	import com.newgonzo.web.css.parser.LexicalUnitStream;
	import com.newgonzo.web.css.properties.IShorthandManager;
	

	public class BorderWidthShorthand extends BorderWidthManager implements IShorthandManager
	{
		protected static const LONGHAND_PROPERTIES:Array =
		[
			BorderProperties.BORDER_TOP_WIDTH,
			BorderProperties.BORDER_RIGHT_WIDTH,
			BorderProperties.BORDER_BOTTOM_WIDTH,
			BorderProperties.BORDER_LEFT_WIDTH
		];
		
		public function BorderWidthShorthand()
		{
			super(BorderProperties.BORDER_WIDTH);
		}
		
		public function get longhandProperties():Array
		{
			return LONGHAND_PROPERTIES;
		}
		
		override public function setValues(document:ICSSDocument, styleMap:ICSSStyleMap, lexicalUnitStream:LexicalUnitStream, priority:String=null, inShorthand:Boolean=false):void
		{
			setTopRightBottomLeftValues(document, styleMap, LONGHAND_PROPERTIES, lexicalUnitStream, priority);
		}
	}
}