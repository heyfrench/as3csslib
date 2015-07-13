package com.newgonzo.web.css.properties.css3.fonts
{
	import com.newgonzo.web.css.properties.LengthManager;
	import com.newgonzo.web.css.values.css3.CSS3Values;

	public class LineHeightManager extends LengthManager
	{
		protected static const VALID_IDENTIFIERS:Array = 
		[
			CSS3Values.NORMAL,
			CSS3Values.NONE
		];
		
		public function LineHeightManager()
		{
			super(FontProperties.LINE_HEIGHT, CSS3Values.NORMAL_VALUE, true, VALID_IDENTIFIERS);
		}
		
	}
}