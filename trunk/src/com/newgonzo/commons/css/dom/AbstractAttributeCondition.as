package com.newgonzo.commons.css.dom
{	
	public class AbstractAttributeCondition
	{
		private var ns:String;
		private var attributeName:String;
		private var isSpecified:Boolean;
		private var attributeValue:String;
		
		public function AbstractAttributeCondition(localName:String, namespaceURI:String, specified:Boolean, value:String)
		{
			attributeName = localName;
			ns = namespaceURI;
			isSpecified = specified;
			attributeValue = value;
		}
		
		public function get namespaceURI():String
		{
			return ns;
		}
		
		public function get localName():String
		{
			return attributeName;
		}
		
		public function get specified():Boolean
		{
			return isSpecified;
		}
		
		public function get value():String
		{
			return attributeValue;
		}
		
		protected function attributeIgnoreCase(node:XML, attrName:String):String
		{
			return node.attributes().(name() && name().toString().toLowerCase() == attrName.toLowerCase()).toString();
		}
		
		public function toString():String
		{
			return "[AttributeCondition(localName=" + attributeName + " value=" + attributeValue + ")]";
		}
	}
}