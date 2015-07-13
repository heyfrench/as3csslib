package org.w3c.dom
{	
	public interface IHistory
	{	
		function go(delta:int = 0):void
		function back():void
		function forward():void
		function get length():uint
		//function pushState(data:Object, title:String = "", url:String = ""):void
		//function clearState():void
	}
}