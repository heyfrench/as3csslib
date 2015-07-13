
package org.w3c.css.sac
{
	public interface ISiblingSelector extends ISelector 
	{
		function get nodeType():int
		function get selector():ISelector
		function get siblingSelector():ISimpleSelector
	}
}
