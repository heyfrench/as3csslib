package com.newgonzo.web.css.properties.css3.box
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.ICSSStyleMap;
	import com.newgonzo.web.css.parser.LexicalUnitStream;
	import com.newgonzo.web.css.properties.IShorthandManager;
	import com.newgonzo.web.css.properties.PropertyManager;

	public class PaddingShorthand extends PropertyManager implements IShorthandManager
	{
		protected static const LONGHAND_PROPERTIES:Array =
		[
			BoxProperties.PADDING_TOP, 
			BoxProperties.PADDING_RIGHT, 
			BoxProperties.PADDING_BOTTOM, 
			BoxProperties.PADDING_LEFT
		];
		
		public function PaddingShorthand()
		{
			super(BoxProperties.PADDING);
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