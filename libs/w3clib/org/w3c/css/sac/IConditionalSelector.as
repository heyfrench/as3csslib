
package org.w3c.css.sac
{
	public interface IConditionalSelector extends ISimpleSelector 
	{
		function get simpleSelector():ISimpleSelector
		function get condition():ICondition
	}
}
