package org.w3c.dom.css
{
	import org.w3c.dom.stylesheets.IStyleSheet;
		
	public interface ICSSStyleSheet extends IStyleSheet
	{	
		function get ownerRule():ICSSRule
		function get cssRules():ICSSRuleList
		function insertRule(rule:String, index:uint):void
		function deleteRule(index:uint):void
	}
}
