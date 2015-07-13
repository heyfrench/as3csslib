package org.w3c.dom.stylesheets
{	
	public interface IMediaList
	{	
		function appendMedium(newMedium:String):void
		function deleteMedium(oldMedium:String):void
		function get length():uint
		function item(index:uint):String
		function get mediaText():String
		function set mediaText(value:String):void
	}
}
