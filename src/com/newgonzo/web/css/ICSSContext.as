package com.newgonzo.web.css
{
	import com.newgonzo.web.css.properties.IPropertyManager;
	import com.newgonzo.web.css.views.ICSSView;
	
	import flash.net.URLRequest;
	
	public interface ICSSContext
	{
		function get factory():ICSSFactory
		
		function addPropertyManager(manager:IPropertyManager):void
		function getPropertyManager(propertyName:String):IPropertyManager
		
		//function getSystemColor(color:String):IValue
		
		function getView(node:*):ICSSView
	}
}