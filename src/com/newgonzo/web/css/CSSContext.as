package com.newgonzo.web.css
{
	import com.newgonzo.web.css.properties.IPropertyManager;
	import com.newgonzo.web.css.properties.PropertyManager;
	import com.newgonzo.web.css.views.ICSSView;
	import com.newgonzo.web.css.views.XMLCSSView;
	
	import flash.utils.Dictionary;

	public class CSSContext implements ICSSContext
	{
		protected var cssFactory:ICSSFactory;
		protected var defaultView:ICSSView;
		protected var propertyManagers:Dictionary = new Dictionary();
		
		public function CSSContext(defaultCSSView:ICSSView = null, objectFactory:ICSSFactory = null)
		{
			cssFactory = objectFactory ? objectFactory : new CSSFactory();
			defaultView = defaultCSSView ? defaultCSSView : new XMLCSSView();
		}
		
		public function get factory():ICSSFactory
		{
			return cssFactory;
		}
		
		public function addPropertyManager(manager:IPropertyManager):void
		{
			propertyManagers[manager.propertyName] = manager;
		}
		
		public function getPropertyManager(propertyName:String):IPropertyManager
		{
			var manager:IPropertyManager = propertyManagers[propertyName] as IPropertyManager
			
			if(!manager)
			{
				manager = createPropertyManager(propertyName);
				propertyManagers[propertyName] = manager;
			}
			
			return manager;
		}
		
		public function getView(node:*):ICSSView
		{
			return defaultView;
		}
		
		public function addPropertyManagers(managers:Array):void
		{
			var manager:IPropertyManager;
			
			for each(manager in managers)
			{
				addPropertyManager(manager);
			}
		}
		
		protected function createPropertyManager(propertyName:String):IPropertyManager
		{
			return new PropertyManager(propertyName);
		}
	}
}