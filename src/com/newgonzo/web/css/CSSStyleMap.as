package com.newgonzo.web.css
{
	import com.newgonzo.web.css.properties.CSSPriority;
	
	import flash.utils.Dictionary;
	
	import org.w3c.dom.css.ICSSValue;	

	public class CSSStyleMap implements ICSSStyleMap
	{
		private var propsByName:Dictionary;
		private var propNames:Array;
		private var propPriorities:Dictionary;
		
		public function CSSStyleMap()
		{
			propsByName = new Dictionary();
			propNames = new Array();
			propPriorities = new Dictionary();
		}
		
		public function get styleNames():Array
		{
			return propNames.concat();
		}
		
		public function setProperty(name:String, value:ICSSValue, priority:String = null):void
		{
			propsByName[name] = value;
			
			if(propNames.indexOf(name) == -1)
			{
				propNames.push(name);
			}
			
			setPropertyPriority(name, priority);
		}
		
		public function getProperty(name:String):ICSSValue
		{
			return propsByName[name] as ICSSValue;
		}
		
		public function hasProperty(name:String):Boolean
		{
			return (propsByName[name] as ICSSValue) != null;
		}
		
		public function setPropertyPriority(name:String, value:String):void
		{
			propPriorities[name] = value;
		}
		
		public function getPropertyPriority(name:String):String
		{
			return propPriorities[name];
		}
		
		public function removeProperty(name:String):ICSSValue
		{
			if(!propsByName[name])
			{
				return null;
			}
			
			var val:ICSSValue = getProperty(name);
			
			delete propsByName[name];
			propNames.splice(propNames.indexOf(name), 1);
			
			return val;
		}
		
		public function toCSSString():String
		{
			var s:String = "";
			var name:String;
			var value:ICSSSerializable;
			
			var names:Array = propNames.sort();
			
			for each(name in names)
			{
				value = propsByName[name] as ICSSSerializable;
				s += "\t" + name + ": " + value.toCSSString() + (propPriorities[name] == CSSPriority.IMPORTANT ? " !important" : "") + ";\n";	
			}
			
			return s;
		}
	}
}
