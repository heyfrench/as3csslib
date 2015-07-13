/**
 * String utility class
 */
package com.newgonzo.commons.utils
{
	public class StringUtil
	{	
		/**
		 * Pads a string by inserting the specified number of spaces between each character
		 * 
		 * @param text The string to pad
		 * @param pad The number of spaces to use
		 * 
		 * @return The newly padded string
		 */
		public static function padChars(text:String, pad:Number):String
		{
			// insert spaces
			var c:String = new String();
		
			for(var i:Number=0; i<text.length; i++)
			{
				c += text.charAt(i);
			
				for(var j:Number=0; j<pad; j++)
				{
					c += " ";
				}
			}
		
			return c;
		}
	
		public static function getBoolean(s:String):Boolean
		{
			return s.toLowerCase() == "true";
		}
	
		public static function getDirectoryFromPath(path:String):String
		{
			var stripped:String = path.split("?")[0];
			return stripped.substr(0, stripped.lastIndexOf("/")) + "/";
		}
	
		/**
		 * Remove whitespace from beginning and end of a string
		 *
		 * @param st The string to trim
		 * @return Trimmed string
		 */
		public static function trim(st:String):String
		{
			return StringUtil.rtrim(StringUtil.ltrim(st));
		}
	
		/**
		 * Remove whitespace from end of a string
		 *
		 * @param st The string to trim
		 * @param trim The optional string to cut off
		 * @return Trimmed string
		 */
		public static function rtrim(st:String, trim:String = " "):String
		{
			var pos:Number = st.length - 1;
				
			while(st.charAt(pos) == trim)
			{
				pos--;
			}
		
			return st.substring(0, pos + 1);
		}
	
		/**
		 * Remove whitespace from beginning of a string
		 *
		 * @param st The string to trim
		 * @param trim The optional string to cut off
		 * @return Trimmed string
		 */
		public static function ltrim(st:String, trim:String = " "):String
		{
			var pos:Number = 0;
		
			while(st.charAt(pos) == trim)
			{
				pos++;
			}
		
			return st.substr(pos);
		}
	
		/**
		 * Retrieves the extension from a file name, ignoring query string
		 * 
		 * @param filename The file name with extension
		 * 
		 * @return The extension without the dot
		 */
		public static function getExtension(filename:String):String
		{
			var s:String;
		
			// strip off query string if it's there
			if(filename.indexOf("?") != -1)
			{
				s = filename.split("?")[0];
			}
			else
			{
				s = filename;
			}
		
			return s.substr(s.lastIndexOf(".") + 1);
		}
	
		/**
		 * Returns the index of the first occurrence of any string in <code>test</code> within
		 * <code>target</code>
		 * 
		 * @param target The string to check
		 * @param test The array of strings to perform the search with
		 */
		public static function indexOfAny(target:String, test:Array):Number
		{
			var n:Number = test.length;
			var index:Number;
		
			for(var i:Number=0; i<n; i++)
			{
				index = target.indexOf(test[i]);
			
				if(index != -1)
				{
					return index;
				}
			}
		
			return -1;
		}
	}
}