package com.newgonzo.web.css.selectors
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.views.ICSSView;
	
	import org.w3c.css.sac.ConditionTypes;
	import org.w3c.css.sac.IAttributeCondition;	

	public class IdCondition extends AbstractAttributeCondition implements IExtendedCondition, IAttributeCondition
	{		
		public function IdCondition(value:String)
		{
			super(null, null, false, value);
		}
		
		override public function get specificity():uint
		{
			return 1 << 16;	
		}
		
		override public function match(view:ICSSView, node:*):Boolean
		{
			return view.cssId(node) == value;
		}
		
		public function get conditionType():int
		{
			return ConditionTypes.SAC_ID_CONDITION;
		}
		
		public function toCSSString(document:ICSSDocument):String
		{
			return "#" + value;
		}
	}
}