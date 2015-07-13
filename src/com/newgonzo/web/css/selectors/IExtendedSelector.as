package com.newgonzo.web.css.selectors
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.views.ICSSView;
	
	import org.w3c.css.sac.ISimpleSelector;		

	public interface IExtendedSelector extends ISimpleSelector
	{
		function get specificity():uint
		function match(view:ICSSView, node:*):Boolean
		function toCSSString(document:ICSSDocument):String
	}
}
