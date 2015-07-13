package com.newgonzo.web.css.properties.css3.box
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.ICSSStyleMap;
	import com.newgonzo.web.css.parser.LexicalUnitStream;
	import com.newgonzo.web.css.properties.IShorthandManager;
	import com.newgonzo.web.css.properties.PropertyManager;
	
	public class MarginShorthand extends PropertyManager implements IShorthandManager
	{
		protected static const LONGHAND_PROPERTIES:Array =
		[
			BoxProperties.MARGIN_TOP, 
			BoxProperties.MARGIN_RIGHT, 
			BoxProperties.MARGIN_BOTTOM, 
			BoxProperties.MARGIN_LEFT
		];
		
		public function MarginShorthand()
		{
			super(BoxProperties.MARGIN);
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