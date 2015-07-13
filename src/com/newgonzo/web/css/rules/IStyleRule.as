package com.newgonzo.web.css.rules
{
	import com.newgonzo.web.css.ICSSDocumentNode;
	
	import org.w3c.css.sac.ISelectorList;
	import org.w3c.dom.css.ICSSStyleRule;

	public interface IStyleRule extends ICSSStyleRule, ICSSDocumentNode
	{
		function get selectors():ISelectorList
	}
}