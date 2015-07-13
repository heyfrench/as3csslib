package com.newgonzo.web.css
{
	import com.newgonzo.web.css.properties.utils.PropertyNameUtil;
	import com.newgonzo.web.css.values.IColorValue;
	import com.newgonzo.web.css.views.ICSSView;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	import org.w3c.dom.css.CSSPrimitiveValueTypes;
	import org.w3c.dom.css.CSSValueTypes;
	import org.w3c.dom.css.ICSSPrimitiveValue;
	import org.w3c.dom.css.ICSSValue;
	import org.w3c.dom.css.ICSSValueList;

	dynamic public class CSSComputedStyle extends CSSStyleDeclaration implements IEventDispatcher
	{
		private var cssView:ICSSView;
		private var styledNode:*;
		private var selector:ICSSStyleSelector;
		private var pseudoElt:String;
		
		private var computedValues:Dictionary;
		
		private var dispatcher:IEventDispatcher;
		
		public function CSSComputedStyle(styleSelector:ICSSStyleSelector, node:*, view:ICSSView, styleMap:ICSSStyleMap, pseudoElement:String = null)
		{
			super(styleMap);
			
			selector = styleSelector;
			cssView = view;
			styledNode = node;
			pseudoElt = pseudoElement;
			
			computedValues = new Dictionary();
			dispatcher = new EventDispatcher(this);
		}
		
		public function get node():*
		{
			return styledNode;
		}
		
		public function get view():ICSSView
		{
			return cssView;
		}
		
		public function get pseudoElement():String
		{
			return pseudoElt;
		}
		
		public function getComputedValue(propertyName:String):*
		{
			var prop:String = PropertyNameUtil.fromCamelCase(propertyName);
			
			if(!styleMap.hasProperty(prop))
			{
				return null;
			}
			
			var value:* = computedValues[prop];
			
			if(value == undefined)
			{
				var cssValue:ICSSValue = styleMap.getProperty(prop);
				
				if(cssValue.cssValueType == CSSValueTypes.CSS_INHERIT)
				{
					value = getInheritedValue(prop);
				}
				else
				{
					value = computeValue(cssValue);
				}
				
				computedValues[prop] = value;
			}
			
			return value;
		}
		
		public function setComputedValue(propertyName:String, value:*):void
		{
			var prop:String = PropertyNameUtil.fromCamelCase(propertyName);
			computedValues[prop] = value;
		}
		
		public function intValue(name:String):int
		{
			return int(getComputedValue(name));
		}
		
		public function numberValue(name:String):Number
		{
			return Number(getComputedValue(name));
		}
		
		public function stringValue(name:String):String
		{
			return getComputedValue(name).toString();
		}
		
		/* IEventDispatcher implementation */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			dispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			return dispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return dispatcher.hasEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean
		{
			return dispatcher.willTrigger(type);
		}
		
		override public function toString():String
		{
			var s:String = "";
			var name:String;
			var value:*;
			
			var names:Array = styleMap.styleNames;
			
			for each(name in names)
			{
				value = getComputedValue(name);
				s += "\t" + name + ": " + value + ";\n";	
			}
			
			return s;
		}
		
		override protected function getPropertyValueInternal(propertyName:String):*
		{
			return getComputedValue(propertyName);
		}
		
		protected function getInheritedValue(propertyName:String):*
		{
			// TODO: handle inherit better than this
			var parent:* = view.parent(styledNode);
			var prop:String = PropertyNameUtil.fromCamelCase(propertyName);
			var parentStyle:CSSComputedStyle;
			var value:*;
			
			if(parent)
			{
				while(parent && value == null)
				{
					parentStyle = selector.getComputedStyle(view, parent, pseudoElt);
					
					if(parentStyle)
					{
						value = parentStyle.getComputedValue(prop);
					
						if(value != null)
						{
							return value;
						}
					}
					
					parent = view.parent(parent);
				}
				
				return null;
			}
			else
			{
				// TODO: return the default value
				return null;
			}
		}
		
		protected function computeValue(value:ICSSValue):*
		{
			var computed:*;
			
			switch(value.cssValueType)
			{
				case CSSValueTypes.CSS_PRIMITIVE_VALUE:
					computed = computePrimitiveValue(value as ICSSPrimitiveValue);
					break;

				case CSSValueTypes.CSS_VALUE_LIST:
					
					// TODO: Cleanup?
					computed = new Array();
					var list:ICSSValueList = value as ICSSValueList;
					
					var len:int = list.length;
					var i:int = 0;
					
					while(i < len)
					{
						computed.push(computeValue(list.item(i)));
						i++;
					}
					break;

				default:
					computed = null;
					break;
			}
			
			return computed;
		}
		
		protected function computePrimitiveValue(value:ICSSPrimitiveValue):*
		{
			var computed:*;
			
			switch(value.primitiveType)
			{
				case CSSPrimitiveValueTypes.CSS_RGBCOLOR:
				case CSSPrimitiveValueTypes.CSS_HSLCOLOR:
					computed = (value as IColorValue).rgb;
					break;
				case CSSPrimitiveValueTypes.CSS_RGBACOLOR:
				case CSSPrimitiveValueTypes.CSS_HSLACOLOR:
					computed = (value as IColorValue).argb;
					break;
				case CSSPrimitiveValueTypes.CSS_NUMBER:
				case CSSPrimitiveValueTypes.CSS_PX:
					computed = value.floatValue;
					break;
				case CSSPrimitiveValueTypes.CSS_CM:
					// 1px = 0.028cm
					computed = value.floatValue * 35.7142857; // 1/0.028
					break;
				case CSSPrimitiveValueTypes.CSS_MM:
					// 1px = 0.28mm
					computed = value.floatValue * 3.57142857; // 1/0.28
					break;
				case CSSPrimitiveValueTypes.CSS_IN:
					// 1in = 25.4mm
					computed = value.floatValue * 90.7142857; // 25.4/0.28
					break;
				case CSSPrimitiveValueTypes.CSS_PT:
					// 1pt = 1px at 96dpi
					// flash uses 72dpi, so adjust from 96dpi to 72dpi
					computed = value.floatValue * 1.33333333; // 4/3
					break;
				case CSSPrimitiveValueTypes.CSS_PC:
					// 1pc = 12pt
					computed = value.floatValue * 16; // (4/3) * 12
					break;
				case CSSPrimitiveValueTypes.CSS_EMS:
				case CSSPrimitiveValueTypes.CSS_EXS:
					// TODO: Fixme
					computed = value.floatValue;
					break;
				default:
					computed = value.cssText;
			}
			
			return computed;
		}
	}
}