package com.newgonzo.web.css
{
	import com.newgonzo.web.css.net.DefaultRequestHandler;
	import com.newgonzo.web.css.net.IRequestHandler;
	import com.newgonzo.web.css.parser.CSSParser;
	import com.newgonzo.web.css.parser.ICSSParser;
	import com.newgonzo.web.css.rules.IStyleRule;
	import com.newgonzo.web.css.rules.ImportRule;
	import com.newgonzo.web.css.rules.MediaRule;
	import com.newgonzo.web.css.rules.NamespaceRule;
	import com.newgonzo.web.css.rules.StyleRule;
	import com.newgonzo.web.css.values.AttrValue;
	import com.newgonzo.web.css.values.FloatValue;
	import com.newgonzo.web.css.values.FunctionValue;
	import com.newgonzo.web.css.values.HSLColorValue;
	import com.newgonzo.web.css.values.IdentValue;
	import com.newgonzo.web.css.values.RGBColorValue;
	import com.newgonzo.web.css.values.RectValue;
	import com.newgonzo.web.css.values.StringValue;
	import com.newgonzo.web.css.values.URIValue;
	import com.newgonzo.web.css.values.css3.CSS3Values;
	
	import flash.net.URLRequest;
	
	import org.w3c.css.sac.CSSError;
	import org.w3c.css.sac.IDocumentHandler;
	import org.w3c.css.sac.IErrorHandler;
	import org.w3c.css.sac.ILexicalUnit;
	import org.w3c.css.sac.IParser;
	import org.w3c.css.sac.ISACMediaList;
	import org.w3c.css.sac.ISelectorList;
	import org.w3c.css.sac.LexicalUnitTypes;
	import org.w3c.css.sac.helpers.IParserFactory;
	import org.w3c.dom.css.CSSPrimitiveValueTypes;
	import org.w3c.dom.css.CSSValueTypes;
	import org.w3c.dom.css.ICSSMediaRule;
	import org.w3c.dom.css.ICSSNamespaceRule;
	import org.w3c.dom.css.ICSSRule;
	import org.w3c.dom.css.ICSSRuleList;
	import org.w3c.dom.css.ICSSStyleDeclaration;
	import org.w3c.dom.css.ICSSStyleSheet;
	import org.w3c.dom.css.ICSSValue;
	import org.w3c.dom.stylesheets.IMediaList;
	
	public class CSSFactory implements ICSSFactory, IParserFactory
	{
		public function createParser():ICSSParser
		{
			return makeParser() as ICSSParser;
		}
			
		public function createDocumentHandler(document:ICSSDocument):IDocumentHandler
		{
			return new CSSDocumentHandler(document);	
		}
		
		public function createErrorHandler(document:ICSSDocument):IErrorHandler
		{
			return new CSSErrorHandler(document);	
		}
		
		public function createRequestHandler(request:URLRequest):IRequestHandler
		{
			return new DefaultRequestHandler(request);
		}
		
		// Required by org.w3c.css.sac.helpers.IParserFactory
		public function makeParser():IParser
		{
			return new CSSParser();
		}
		
		public function createMediaQuery(media:*):CSSMediaQuery
		{
			return new CSSMediaQuery(media);
		}
		
		public function createDocument(context:ICSSContext, uri:String = null, origin:int = -1):ICSSDocument
		{
			return new CSSDocument(context, uri, origin);
		}
		
		public function createStyleSheet(document:ICSSDocument = null, media:IMediaList = null, ownerRule:ICSSRule = null, cssRules:ICSSRuleList = null):ICSSStyleSheet
		{
			return new CSSStyleSheet(document, media, ownerRule);
		}
		
		public function createNamespaceRule(parentStyleSheet:ICSSStyleSheet, prefix:String, namespaceURI:String):ICSSNamespaceRule
		{
			return new NamespaceRule(parentStyleSheet, prefix, namespaceURI);
		}
		
		public function createStyleRule(parentStyleSheet:ICSSStyleSheet, selectors:ISelectorList, style:ICSSStyleDeclaration):IStyleRule
		{
			return new StyleRule(parentStyleSheet, selectors, style);
		}
		
		public function createImportRule(parentStyleSheet:ICSSStyleSheet, uri:String, media:ISACMediaList):ICSSRule
		{
			return new ImportRule(parentStyleSheet, uri, media);
		}
		
		public function createMediaRule(parentStyleSheet:ICSSStyleSheet, media:IMediaList, cssRules:ICSSRuleList = null):ICSSMediaRule
		{
			return new MediaRule(parentStyleSheet, media, cssRules);
		}
		
		public function createStyleDeclaration(styleMap:ICSSStyleMap, parentRule:ICSSRule = null):ICSSStyleDeclaration
		{
			return new CSSStyleDeclaration(styleMap, parentRule);
		}
		
		public function createStyleMap():ICSSStyleMap
		{
			return new CSSStyleMap();
		}
		
		public function createValue(unit:ILexicalUnit):ICSSValue
		{
			var value:ICSSValue;
			var type:uint = unit.type;
			
			// TODO: Should this be here?
			switch(type)
			{
				case LexicalUnitTypes.SAC_URI:
					value = new URIValue(unit.stringValue);
					break;
					
				case LexicalUnitTypes.SAC_RGBCOLOR:
					value = createColorValue(CSSPrimitiveValueTypes.CSS_RGBCOLOR, unit.parameters);
					break;
				
				case LexicalUnitTypes.SAC_RGBACOLOR:
					value = createColorValue(CSSPrimitiveValueTypes.CSS_RGBACOLOR, unit.parameters);
					break;
				
				case LexicalUnitTypes.SAC_HSLCOLOR:
					value = createColorValue(CSSPrimitiveValueTypes.CSS_HSLCOLOR, unit.parameters);
					break;
				
				case LexicalUnitTypes.SAC_HSLACOLOR:
					value = createColorValue(CSSPrimitiveValueTypes.CSS_HSLACOLOR, unit.parameters);
					break;
					
				case LexicalUnitTypes.SAC_IDENT:
					value = new IdentValue(unit.stringValue);
					break;
					
				case LexicalUnitTypes.SAC_STRING_VALUE:
					value = new StringValue(CSSPrimitiveValueTypes.CSS_STRING, unit.stringValue);
					break;
					
				case LexicalUnitTypes.SAC_INTEGER:
				case LexicalUnitTypes.SAC_REAL:
					value = new FloatValue(CSSPrimitiveValueTypes.CSS_NUMBER, unit.floatValue);
					break;
					
				case LexicalUnitTypes.SAC_PERCENTAGE:
					value = new FloatValue(CSSPrimitiveValueTypes.CSS_PERCENTAGE, unit.floatValue);
					break;
				
				case LexicalUnitTypes.SAC_EM:
					value = new FloatValue(CSSPrimitiveValueTypes.CSS_EMS, unit.floatValue);
					break;
					
				case LexicalUnitTypes.SAC_EX:
					value = new FloatValue(CSSPrimitiveValueTypes.CSS_EXS, unit.floatValue);
					break;
					
				case LexicalUnitTypes.SAC_PIXEL:
					value = new FloatValue(CSSPrimitiveValueTypes.CSS_PX, unit.floatValue);
					break;
					
				case LexicalUnitTypes.SAC_CENTIMETER:
					value = new FloatValue(CSSPrimitiveValueTypes.CSS_CM, unit.floatValue);
					break;
					
				case LexicalUnitTypes.SAC_MILLIMETER:
					value = new FloatValue(CSSPrimitiveValueTypes.CSS_MM, unit.floatValue);
					break;
					
				case LexicalUnitTypes.SAC_INCH:
					value = new FloatValue(CSSPrimitiveValueTypes.CSS_IN, unit.floatValue);
					break;
					
				case LexicalUnitTypes.SAC_POINT:
					value = new FloatValue(CSSPrimitiveValueTypes.CSS_PT, unit.floatValue);
					break;
					
				case LexicalUnitTypes.SAC_PICA:
					value = new FloatValue(CSSPrimitiveValueTypes.CSS_PC, unit.floatValue);
					break;
					
				case LexicalUnitTypes.SAC_DEGREE:
					value = new FloatValue(CSSPrimitiveValueTypes.CSS_DEG, unit.floatValue);
					break;
					
				case LexicalUnitTypes.SAC_RADIAN:
					value = new FloatValue(CSSPrimitiveValueTypes.CSS_RAD, unit.floatValue);
					break;
					
				case LexicalUnitTypes.SAC_GRADIAN:
					value = new FloatValue(CSSPrimitiveValueTypes.CSS_GRAD, unit.floatValue);
					break;
					
				case LexicalUnitTypes.SAC_MILLISECOND:
					value = new FloatValue(CSSPrimitiveValueTypes.CSS_MS, unit.floatValue);
					break;
					
				case LexicalUnitTypes.SAC_SECOND:
					value = new FloatValue(CSSPrimitiveValueTypes.CSS_S, unit.floatValue);
					break;
					
				case LexicalUnitTypes.SAC_HERTZ:
					value = new FloatValue(CSSPrimitiveValueTypes.CSS_HZ, unit.floatValue);
					break;
					
				case LexicalUnitTypes.SAC_KILOHERTZ:
					value = new FloatValue(CSSPrimitiveValueTypes.CSS_KHZ, unit.floatValue);
					break;

				case LexicalUnitTypes.SAC_INHERIT:
					value = CSS3Values.INHERIT_VALUE;
					break;

				case LexicalUnitTypes.SAC_ATTR:
					value = new AttrValue(unit.parameters.stringValue);
					break;
				
				case LexicalUnitTypes.SAC_RECT_FUNCTION:
					// TODO: Break Rect out into own value factory and finish
					value = createRectValue(unit.parameters);
					break;
					
				case LexicalUnitTypes.SAC_COUNTER_FUNCTION:
				case LexicalUnitTypes.SAC_COUNTERS_FUNCTION:
					//value = new FunctionValue(unit, CSSPrimitiveValueTypes.CSS_RECT);
					break;
					
				case LexicalUnitTypes.SAC_FUNCTION:
					value = new FunctionValue(CSSPrimitiveValueTypes.CSS_UNKNOWN, unit.functionName, createArguments(unit.parameters));
					break;
					
				default:
					value = new StringValue(CSSValueTypes.CSS_CUSTOM, unit.stringValue);
					break;
			}
			
			return value;
		}
		
		protected function createRectValue(unit:ILexicalUnit):ICSSValue
		{
			var args:Array = createArguments(unit);
			
			if(args.length != 4)
			{
				throw new CSSError("Error creating RectValue: expected 4 arguments but got " + args.length);
			}
			
			return new RectValue(args[0], args[1], args[2], args[3]);
		}
		
		protected function createColorValue(type:uint, unit:ILexicalUnit):ICSSValue
		{
			// TODO: Error handling here
			
			var args:Array = createArguments(unit);
			var value:ICSSValue;
			
			switch(type)
			{
				case CSSPrimitiveValueTypes.CSS_RGBCOLOR:
				case CSSPrimitiveValueTypes.CSS_RGBACOLOR:
				
					value = new RGBColorValue(type, args[0], args[1], args[2], args[3]);
					break;
				
				case CSSPrimitiveValueTypes.CSS_HSLCOLOR:
				case CSSPrimitiveValueTypes.CSS_HSLACOLOR:
					
					value = new HSLColorValue(type, args[0], args[1], args[2], args[3]);
					break;
			}
			
			return value;
		}
		
		protected function createArguments(unit:ILexicalUnit):Array
		{
			var args:Array = new Array();
			var arg:ILexicalUnit = unit;
			
			while(arg)
			{
				if(arg.type == LexicalUnitTypes.SAC_OPERATOR_COMMA)
				{
					arg = arg.nextLexicalUnit;
				}
				else
				{
					args.push(createValue(arg));
					arg = arg.nextLexicalUnit;
				}
			}
			
			return args;
		}
	}
}