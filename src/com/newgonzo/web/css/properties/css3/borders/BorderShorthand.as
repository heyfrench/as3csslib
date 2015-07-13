package com.newgonzo.web.css.properties.css3.borders
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.ICSSStyleMap;
	import com.newgonzo.web.css.parser.LexicalUnitStream;
	import com.newgonzo.web.css.properties.IPropertyManager;
	import com.newgonzo.web.css.properties.IShorthandManager;
	import com.newgonzo.web.css.properties.PropertyManager;
	
	
	public class BorderShorthand extends PropertyManager implements IShorthandManager
	{
		protected static const LONGHAND_PROPERTIES:Array =
		[
			BorderProperties.BORDER_TOP,
			BorderProperties.BORDER_RIGHT,
			BorderProperties.BORDER_BOTTOM,
			BorderProperties.BORDER_LEFT
		];
		
		public function BorderShorthand()
		{
			super(BorderProperties.BORDER);
		}
		
		public function get longhandProperties():Array
		{
			return LONGHAND_PROPERTIES;
		}
		
		override public function setValues(document:ICSSDocument, styleMap:ICSSStyleMap, lexicalUnitStream:LexicalUnitStream, priority:String = null, inShorthand:Boolean = false):void
		{
			var propName:String;
			var manager:IPropertyManager;
			
			for each(propName in LONGHAND_PROPERTIES)
			{
				manager = document.context.getPropertyManager(propName);
				
				// let the manager read the properties from the stream
				manager.setValues(document, styleMap, lexicalUnitStream, priority, inShorthand);
				
				// reset the stream for the next manager
				lexicalUnitStream.reset();
			}
		}
	}
}