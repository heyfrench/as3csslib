package com.newgonzo.web.css.properties
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.ICSSStyleMap;
	import com.newgonzo.web.css.parser.LexicalUnitStream;
	import com.newgonzo.web.css.properties.utils.ShorthandUtil;
	import com.newgonzo.web.css.values.IValue;
	import com.newgonzo.web.css.values.IdentValue;
	import com.newgonzo.web.css.values.ListValue;
	import com.newgonzo.web.css.values.StringValue;
	
	import org.w3c.css.sac.CSSError;
	import org.w3c.css.sac.CSSErrorTypes;
	import org.w3c.css.sac.ILexicalUnit;
	import org.w3c.css.sac.LexicalUnitTypes;
	import org.w3c.dom.css.CSSValueTypes;
	import org.w3c.dom.css.ICSSValue;
	import org.w3c.dom.css.ICSSValueList;

	public class PropertyManager implements IPropertyManager
	{
		protected var propName:String;
		protected var defaultVal:IValue;
		protected var inherited:Boolean = false;
		
		protected var isList:Boolean = false;
		
		public function PropertyManager(propertyName:String, defaultValue:IValue = null, isInherited:Boolean = false)
		{
			propName = propertyName;
			defaultVal = defaultValue;
			inherited = isInherited;
			
			// FIXME: Is this the best way to do this? Probably not
			isList = defaultVal && defaultVal.cssValueType == CSSValueTypes.CSS_VALUE_LIST;
		}
		
		public function get propertyName():String
		{
			return propName;
		}
		
		public function get defaultValue():IValue
		{
			return defaultVal;
		}
		
		public function get isInherited():Boolean
		{
			return inherited;
		}
		
		public function get isAnimatable():Boolean
		{
			return false;
		}
		
		public function acceptsValue(propertyValue:ILexicalUnit):Boolean
		{
			return true;
		}

		public function setValues(document:ICSSDocument, styleMap:ICSSStyleMap, lexicalUnitStream:LexicalUnitStream, priority:String = null, inShorthand:Boolean = false):void
		{
			var newValue:ICSSValue;
			
			if(isList)
			{
				newValue = createValueList(document, lexicalUnitStream);
			}
			else 
			{
				var propertyValue:ILexicalUnit = lexicalUnitStream.current;
			
				//trace(this + " trying to set value of " + propertyValue);
			
				if(acceptsValue(propertyValue))
				{
					newValue = document.context.factory.createValue(propertyValue);
					
					//trace("accepted: value: " + value);
					
					if(newValue)
					{
						lexicalUnitStream.next();
					}
				}
			}
			
			if(newValue)
			{
				if(!inShorthand && lexicalUnitStream.current)
				{
					throw createSyntaxError("Unhandled " + lexicalUnitStream.current + " in " + propName + " value");
				}
				
				styleMap.setProperty(propName, newValue, priority);
			}
		}
		
		protected function setTopRightBottomLeftValues(document:ICSSDocument, styleMap:ICSSStyleMap, propertyNames:Array, lexicalUnitStream:LexicalUnitStream, priority:String = null):void
		{
			var expandedValues:Array = ShorthandUtil.createTopRightBottomLeftValues(this, lexicalUnitStream);
			var count:int = expandedValues.length;
			
			while(count--)
			{
				// FIXME: These properties need to be set via their PropertyManagers, not directly
				document.context.getPropertyManager(propertyNames[count]).setValues(document, styleMap, new LexicalUnitStream(expandedValues[count]), priority, true);
			}
		}
		
		protected function createValue(document:ICSSDocument, lexicalUnit:ILexicalUnit):ICSSValue
		{
			return document.context.factory.createValue(lexicalUnit);
		}
		
		protected function createStringValue(type:int, value:String):ICSSValue
		{
			return new StringValue(type, value);
		}
		
		protected function createIdentValue(value:String):ICSSValue
		{
			return new IdentValue(value);
		}
		
		protected function createValueList(document:ICSSDocument, lexicalUnitStream:LexicalUnitStream):ICSSValueList
		{
			var list:ListValue = new ListValue();
			var unit:ILexicalUnit = lexicalUnitStream.current;
			var value:ICSSValue;
			
			while(unit && acceptsValue(unit))
			{
				//value = createValue(unit);
				value = document.context.factory.createValue(unit);
				
				if(value)
				{
					list.append(value);
				}
				
				unit = lexicalUnitStream.next();
				
				if(unit && unit.type == LexicalUnitTypes.SAC_OPERATOR_COMMA)
				{
					unit = lexicalUnitStream.next();
				}
				else
				{
					break;
				}
			}
			
			return list;
		}
		
		protected function createSyntaxError(message:String, internalError:Error=null):CSSError
		{
			return new CSSError(message, CSSErrorTypes.SAC_SYNTAX_ERR, internalError);
		}
	}
}