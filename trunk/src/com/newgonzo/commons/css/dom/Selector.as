package com.newgonzo.commons.css.dom
{
	import com.newgonzo.commons.css.sac.ISelector;
	
	public class Selector implements ISelector
	{
		public function Selector()
		{
			
		}
		
		public function select(xml:XML):XMLList
		{
				return <nothing/> + xml;
		}
		
		public function get type():int
		{
			return -1;
		}
	}
}