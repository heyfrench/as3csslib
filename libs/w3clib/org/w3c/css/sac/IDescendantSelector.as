
package org.w3c.css.sac
{
	public interface IDescendantSelector extends ISelector 
	{
		function get ancestorSelector():ISelector
		function get simpleSelector():ISimpleSelector
	}
}
