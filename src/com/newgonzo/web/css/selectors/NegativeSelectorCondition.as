package com.newgonzo.web.css.selectors
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.views.ICSSView;
	
	import org.w3c.css.sac.ConditionTypes;
	import org.w3c.css.sac.ISimpleSelector;	

	public class NegativeSelectorCondition implements IExtendedCondition
	{
		private var selector:IExtendedSelector;
		
		public function NegativeSelectorCondition(simpleSelector:ISimpleSelector)
		{
			selector = simpleSelector as IExtendedSelector;
		}
		
		public function get simpleSelector():ISimpleSelector
		{
			return selector;
		}
		
		public function get specificity():uint
		{
			return selector.specificity;
		}
		
		public function match(view:ICSSView, node:*):Boolean
		{
			return !selector.match(view, node);
		}
		
		public function get conditionType():int
		{
			return ConditionTypes.SAC_NEGATIVE_CONDITION;
		}
		
		public function toCSSString(document:ICSSDocument):String
		{
			return ":not(" + selector.toCSSString(document) + ")";
		}
	}
}