/**
 * @author john
 */
package com.newgonzo.commons.utils
{
	import flash.utils.*;

	public class ClassUtil
	{
		/**
		 * Determines whether a clazz exists.
		 * 
		 * @param name The classpath to look for.
		 */
		public static function classExists(name:String):Boolean
		{
			try
			{
				ClassUtil.getClass(name);
				return true;
			}
			catch(e:Error)
			{
				
			}
			
			return false;
		}

		public static function cleanQualifiedClassName(name:String):String
		{
			return name.replace(/::/, ".");
		}
		
		public static function getClassName(target:*):String
		{
			return ClassUtil.cleanQualifiedClassName(getQualifiedClassName(target));
		}

	 	/**
		 * 
		 * @return The constructor function if the clazz is found
		 */
		public static function getClass(name:String):Class
		{
			return getDefinitionByName(name) as Class;
		}
	
		public static function getPackage(name:String):String
		{
			return name.substr(0, name.lastIndexOf("."));
		}
	}
}