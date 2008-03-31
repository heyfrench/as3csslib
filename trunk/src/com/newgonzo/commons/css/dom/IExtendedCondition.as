package com.newgonzo.commons.css.dom
{
	import com.newgonzo.commons.css.sac.ICondition;
	
	public interface IExtendedCondition extends ICondition
	{
		function match(node:XML):Boolean
	}
}
