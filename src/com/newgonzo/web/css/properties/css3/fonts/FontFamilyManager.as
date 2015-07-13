package com.newgonzo.web.css.properties.css3.fonts
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.ICSSStyleMap;
	import com.newgonzo.web.css.parser.LexicalUnitStream;
	import com.newgonzo.web.css.properties.IdentifierManager;
	import com.newgonzo.web.css.values.IValue;
	import com.newgonzo.web.css.values.ListValue;
	import com.newgonzo.web.css.values.css3.CSS3Values;
	
	import org.w3c.css.sac.ILexicalUnit;
	import org.w3c.css.sac.LexicalUnitTypes;
	import org.w3c.dom.css.CSSPrimitiveValueTypes;
	import org.w3c.dom.css.ICSSValue;

	public class FontFamilyManager extends IdentifierManager
	{
		protected static const VALID_IDENTIFIERS:Array = 
		[
			CSS3Values.SERIF, 
			CSS3Values.SANS_SERIF, 
			CSS3Values.CURSIVE, 
			CSS3Values.FANTASY, 
			CSS3Values.MONOSPACE
		];
		
		public function FontFamilyManager(defaultValue:IValue=null)
		{
			super(FontProperties.FONT_FAMILY, new ListValue(CSS3Values.SANS_SERIF_VALUE), true, VALID_IDENTIFIERS);
		}
		
		override public function acceptsValue(propertyValue:ILexicalUnit):Boolean
		{
			var type:int = propertyValue.type;
			return super.acceptsValue(propertyValue) || type == LexicalUnitTypes.SAC_STRING_VALUE || type == LexicalUnitTypes.SAC_IDENT;
		}
		
		override public function setValues(document:ICSSDocument, styleMap:ICSSStyleMap, lexicalUnitStream:LexicalUnitStream, priority:String = null, inShorthand:Boolean = false):void
		{
			var value:ILexicalUnit = lexicalUnitStream.current;
			var list:ListValue = new ListValue();
			var fontNameParts:Array = new Array();
			
			var fontName:String;
			var cssValue:ICSSValue;
			
			while(value && acceptsValue(value))
			{
				fontNameParts.push(value.stringValue);
				value = lexicalUnitStream.next();
				
				if(!value || value.type == LexicalUnitTypes.SAC_OPERATOR_COMMA)
				{
					// add new string value with all parts of this font name
					fontName = fontNameParts.join(" ");
					
					if(fontNameParts.length > 1)
					{
						cssValue = createStringValue(CSSPrimitiveValueTypes.CSS_STRING, fontName);
					}
					else
					{
						cssValue = createIdentValue(fontName);
					}
					
					list.append(cssValue);
					
					// reset parts
					fontNameParts = new Array();
					
					// skip comma (if there was one)
					value = lexicalUnitStream.next();
				}
			}
			
			// set the style
			styleMap.setProperty(propName, list, priority);
		}
	}
}