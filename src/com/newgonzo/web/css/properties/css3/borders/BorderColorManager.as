package com.newgonzo.web.css.properties.css3.borders
{
	import com.newgonzo.web.css.properties.AbstractColorManager;
	import com.newgonzo.web.css.values.css3.CSS3Values;

	public class BorderColorManager extends AbstractColorManager
	{
		public function BorderColorManager(propertyName:String)
		{
			super(propertyName, CSS3Values.CURRENTCOLOR_VALUE, false);
		}
	}
}