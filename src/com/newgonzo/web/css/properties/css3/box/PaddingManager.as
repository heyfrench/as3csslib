package com.newgonzo.web.css.properties.css3.box
{
	import com.newgonzo.web.css.properties.LengthManager;
	import com.newgonzo.web.css.values.css3.CSS3Values;

	public class PaddingManager extends LengthManager
	{
		public function PaddingManager(propertyName:String)
		{
			super(propertyName, CSS3Values.ZERO_VALUE, false);
		}
	}
}