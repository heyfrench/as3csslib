package org.w3c.dom.stylesheets
{
	import org.w3c.dom.INode;
	
	public interface IStyleSheet
	{
		function get ownerNode():INode
		function get parentStyleSheet():IStyleSheet
		
		function set disabled(value:Boolean):void
		function get disabled():Boolean
		
		function get href():String
		
		function get title():String
		function get type():String
		function get media():IMediaList
	}
}