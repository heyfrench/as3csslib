
package com.newgonzo.commons.css.sac
{
	public interface IAttributeCondition extends ICondition 
	{
		function get namespaceURI():String
		function get localName():String
		function get specified():Boolean
		function get value():String
	}
}
