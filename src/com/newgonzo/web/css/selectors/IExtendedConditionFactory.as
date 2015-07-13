package com.newgonzo.web.css.selectors
{
	import org.w3c.css.sac.ICondition;
	import org.w3c.css.sac.IConditionFactory;
	import org.w3c.css.sac.INegativeCondition;
	import org.w3c.css.sac.ISimpleSelector;

	public interface IExtendedConditionFactory extends IConditionFactory
	{
		function createNegativeSelectorCondition(simpleSelector:ISimpleSelector):ICondition
	}
}