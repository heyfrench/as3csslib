package com.newgonzo.commons.css.dom
{
	import com.newgonzo.commons.css.sac.ISimpleSelector
	
	public interface IExtendedSelector extends ISimpleSelector
	{
		function select(xml:XML):XMLList;
		//function match(node:XML):Boolean;
	}
}
