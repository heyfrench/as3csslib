package com.newgonzo.web.css.selectors
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.views.ICSSView;
	
	import org.w3c.css.sac.ConditionTypes;
	import org.w3c.css.sac.IAttributeCondition;	

	public class ClassCondition extends AbstractAttributeCondition implements IExtendedCondition, IAttributeCondition
	{		
		public function ClassCondition(namespaceURI:String, value:String)
		{
			super(null, namespaceURI, false, value);
		}

		override public function match(view:ICSSView, node:*):Boolean
		{
			var cssClass:String = view.cssClass(node);
			
			if(!cssClass) return false;
			
			return cssClass.split(/\s+/g).indexOf(value) != -1;
		}
		
		public function get conditionType():int
		{
			return ConditionTypes.SAC_CLASS_CONDITION;
		}
		
		public function toCSSString(document:ICSSDocument):String
		{
			return "." + value;
		}
	}
}