package com.newgonzo.web.css
{
	public class CSSMediaQuery
	{
		private var cssMedias:Array;
		
		// TODO: Everything
		public function CSSMediaQuery(media:* = null)
		{
			if(media is Array)
			{
				cssMedias = media as Array;
			}
			
			if(media is String)
			{
				cssMedias = [media as String];
			}
		}
		
		public function toString():String
		{
			return toCSSString();
		}
		
		public function toCSSString():String
		{
			return cssMedias.join(",");
		}
	}
}