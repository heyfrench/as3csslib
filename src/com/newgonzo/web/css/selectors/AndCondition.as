package com.newgonzo.web.css.selectors
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.views.ICSSView;
	
	import org.w3c.css.sac.ConditionTypes;
	import org.w3c.css.sac.ICombinatorCondition;
	import org.w3c.css.sac.ICondition;	

	public class AndCondition extends AbstractCombinatorCondition implements IExtendedCondition, ICombinatorCondition
	{
		public function AndCondition(firstCondition:ICondition, secondCondition:ICondition)
		{
			super(firstCondition, secondCondition);
		}
		
		public function match(view:ICSSView, node:*):Boolean
		{
			return condition1.match(view, node) && condition2.match(view, node);
		}
		
		public function get conditionType():int
		{
			return ConditionTypes.SAC_AND_CONDITION;
		}
		
		public function toCSSString(document:ICSSDocument):String
		{
			return condition1.toCSSString(document) + condition2.toCSSString(document);
		}
	}
}