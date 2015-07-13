package com.newgonzo.web.css.selectors
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.views.ICSSView;
	
	import org.w3c.css.sac.ICondition;

	public interface IExtendedCondition extends ICondition
	{
		function get specificity():uint
		function match(view:ICSSView, node:*):Boolean
		function toCSSString(document:ICSSDocument):String
	}
}
