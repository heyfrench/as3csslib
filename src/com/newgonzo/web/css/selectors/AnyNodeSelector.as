package com.newgonzo.web.css.selectors
{
	import org.w3c.css.sac.SelectorTypes;	

	public class AnyNodeSelector extends ElementSelector implements IExtendedSelector
	{
		public function AnyNodeSelector(namespaceURI:String)
		{
			super(namespaceURI);
		}
		
		override public function get specificity():uint
		{
			return 0;
		}
		
		override public function get type():int
		{
			return SelectorTypes.SAC_ANY_NODE_SELECTOR;
		}
	}
}