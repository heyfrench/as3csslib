package com.newgonzo.web.css.selectors
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.views.ICSSView;
	
	import org.w3c.css.sac.ICondition;
	import org.w3c.css.sac.IConditionalSelector;
	import org.w3c.css.sac.ISimpleSelector;
	import org.w3c.css.sac.SelectorTypes;	

	public class ConditionalSelector implements IExtendedSelector, IConditionalSelector
	{
		private var selector:IExtendedSelector;
		private var selectorCondition:IExtendedCondition;
		
		public function ConditionalSelector(simpleSelector:ISimpleSelector, condition:ICondition)
		{
			selector = simpleSelector as IExtendedSelector;
			selectorCondition = condition as IExtendedCondition;
		}
		
		public function get specificity():uint
		{
			return selector.specificity + selectorCondition.specificity;	
		}
		
		public function get simpleSelector():ISimpleSelector
		{
			return selector;
		}
		
		public function get condition():ICondition
		{
			return selectorCondition;
		}
		
		public function match(view:ICSSView, node:*):Boolean
		{
			return selector.match(view, node) && selectorCondition.match(view, node);
		}
		
		public function get type():int
		{
			return SelectorTypes.SAC_CONDITIONAL_SELECTOR;
		}
		
		public function toCSSString(document:ICSSDocument):String
		{
			return selector.toCSSString(document) + selectorCondition.toCSSString(document);
		}
	}
}