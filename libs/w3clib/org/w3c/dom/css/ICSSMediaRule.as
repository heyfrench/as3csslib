package org.w3c.dom.css
{
	import org.w3c.dom.stylesheets.IMediaList;
	
	public interface ICSSMediaRule extends ICSSRule
	{
		function get media():IMediaList
		function get cssRules():ICSSRuleList
		function insertRule(rule:String, index:int = int.MAX_VALUE):int
		function deleteRule(index:int):void
	}
}