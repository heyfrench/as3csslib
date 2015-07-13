package com.newgonzo.web.css.parser
{
	import com.newgonzo.web.css.ICSSSerializable;
	
	import org.w3c.css.sac.CSSError;
	import org.w3c.css.sac.CSSErrorTypes;
	import org.w3c.css.sac.ISACMediaList;
	import org.w3c.dom.stylesheets.IMediaList;		

	dynamic public class MediaList extends Array implements IMediaList, ISACMediaList, ICSSSerializable
	{
		public function MediaList()
		{
			super();
		}
		
		public function item(index:uint):String
		{
			return this[index] as String;
		}
		
		public function get mediaText():String
		{
			return toCSSString();
		}
		public function set mediaText(value:String):void
		{
			throw new CSSError("mediaText setter is not supported", CSSErrorTypes.SAC_NOT_SUPPORTED_ERR);
		}
		
		public function appendMedium(medium:String):void
		{
			push(medium);
		}
		
		public function deleteMedium(medium:String):void
		{
			var idx:int = indexOf(medium);
			
			if(idx != -1)
			{
				splice(idx, 1);
			}
		}
		
		public function toCSSString():String
		{
			return join(",");
		}
		
		public function toString():String
		{
			return toCSSString();
		}
	}
}