package com.newgonzo.web.css.properties.css3.borders
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.ICSSStyleMap;
	import com.newgonzo.web.css.parser.LexicalUnitStream;
	import com.newgonzo.web.css.properties.IShorthandManager;
	

	public class BorderStyleShorthand extends BorderStyleManager implements IShorthandManager
	{
		protected static const LONGHAND_PROPERTIES:Array =
		[
			BorderProperties.BORDER_TOP_STYLE,
			BorderProperties.BORDER_RIGHT_STYLE,
			BorderProperties.BORDER_BOTTOM_STYLE,
			BorderProperties.BORDER_LEFT_STYLE
		];
		
		public function BorderStyleShorthand()
		{
			super(BorderProperties.BORDER_STYLE);
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