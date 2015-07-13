package com.newgonzo.web.css.properties.css3.borders
{
	import com.newgonzo.web.css.properties.LengthManager;
	import com.newgonzo.web.css.values.css3.CSS3Values;

	public class BorderRadiusManager extends LengthManager
	{
		public function BorderRadiusManager(propertyName:String)
		{
			super(propertyName, CSS3Values.ZERO_VALUE, false);
		}
	}
}