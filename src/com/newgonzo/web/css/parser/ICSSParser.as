package com.newgonzo.web.css.parser
{
	import org.w3c.css.sac.IParser;
	import org.w3c.css.sac.ISACMediaList;
	
	public interface ICSSParser extends IParser
	{
		function parseMedia(input:String):ISACMediaList
	}
}
