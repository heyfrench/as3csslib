package com.newgonzo.web.css.properties.css3.backgrounds
{
	import com.newgonzo.web.css.properties.AbstractColorManager;
	import com.newgonzo.web.css.values.css3.CSS3Values;

	public class BackgroundColorManager extends AbstractColorManager
	{
		public function BackgroundColorManager()
		{
			super(BackgroundProperties.BACKGROUND_COLOR, CSS3Values.TRANSPARENT_VALUE, false);
		}
		
	}
}