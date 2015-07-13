package com.newgonzo.web.css.properties.utils
{
	import flash.utils.Dictionary;
	
	public class PropertyNameUtil
	{
		public static function isCamelCase(value:String):Boolean
		{
			return value != value.toLowerCase();
		}
		
		public static function needsCamelCase(value:String):Boolean
		{
			return value.indexOf("-") != -1;
		}
		
		public static function fromCamelCase(value:String):String
		{
			if(!isCamelCase(value)) return value;
			
			var property:String = "";
			
			var i:int = 0;
			var code:int;
			var prev:int;
			var next:int;
			var len:int = value.length;
			
			while(i < len)
			{
				prev = code;
				code = value.charCodeAt(i);
				next = value.charCodeAt(i + 1);
				
				// uppercase and the previous wasn't
				// or uppercase and next isn't
				if(isAZ(code) && (!isAZ(prev) || !isAZ(next))) // A-Z
				{
					property += "-";
				}
				
				property += value.charAt(i).toLowerCase();
				
				i++;
			}
			
			return property;
		}
		
		public static function toCamelCase(value:String):String
		{
			if(!needsCamelCase(value)) return value;
			
			var camel:String = "";
			var i:int = 0;
			var char:String;
			var len:int = value.length;
			
			while(i < len)
			{
				char = value.charAt(i);
				
				if(char == "-")
				{
					// consume "-"
					i++;
					// cap and add next letter
					camel += value.charAt(i).toUpperCase();
				}
				else
				{
					camel += char;
				}
				
				i++;
			}
			
			return camel;
		}
		
		private static function isAZ(code:int):Boolean
		{
			return code >= 0x41 && code <= 0x5A;
		}
	}
}