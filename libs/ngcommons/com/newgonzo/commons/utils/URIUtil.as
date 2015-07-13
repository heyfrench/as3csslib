
package com.newgonzo.commons.utils
{
	import com.adobe.net.URI;
	
	public class URIUtil
	{
		public static function getDirectory(uri:String):String
		{
			var helper:URI = new URI(uri);
			helper.chdir("./");
			return helper.toString();	
		}
		
		public static function getAbsolute(uri:String, base:String):String
		{
			var helper:URI = new URI(uri);
			helper.makeAbsoluteURI(new URI(base));
			return helper.toString();
		}
		
		public static function getFragment(uri:String):String
		{
			var helper:URI = new URI(uri);
			return helper.fragment;
		}
		
		public static function isFragment(uri:String):Boolean
		{
			return uri.match(/^\s*#/) != null;
		}
		
		public static function stripFragment(uri:String):String
		{
			var helper:URI = new URI(uri);
			var result:String = helper.toString();
			return result.substr(0, result.indexOf("#" + helper.fragment));
		}
		
		public static function getDomain(uri:String):String
		{
			var helper:URI = new URI(uri);
			return helper.authority;
		}
		
		public static function getFilename(uri:String):String
		{
			var helper:URI = new URI(uri);
			return helper.getFilename();
		}
	}
}