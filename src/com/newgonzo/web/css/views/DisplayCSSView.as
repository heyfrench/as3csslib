package com.newgonzo.web.css.views
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	public class DisplayCSSView extends ObjectCSSView
	{
		public function DisplayCSSView(media:*=null, propertyMap:Object=null)
		{
			super(media, propertyMap);
		}
		
		override public function isType(node:*, localName:String):Boolean
		{
			// TODO: Support inheritance?
			return super.isType(node, localName);
		}
		
		override public function childIndex(node:*):int
		{
			var display:DisplayObject = node as DisplayObject;
			
			if(display && display.parent && display.parent.contains(display))
			{
				return display.parent.getChildIndex(display);
			}
			
			return -1;
		}
		
		override public function child(node:*, index:int):*
		{
			var container:DisplayObjectContainer = node as DisplayObjectContainer;
			
			if(!container) return null;
			
			if(container.numChildren <= index)
			{
				return null;
			}
			
			return container.getChildAt(index);
		}
		
		override public function textContent(node:*):String
		{
			// TODO: How should this be implemented?
			return "";
		}
	}
}