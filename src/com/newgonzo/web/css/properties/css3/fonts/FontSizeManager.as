package com.newgonzo.web.css.properties.css3.fonts
{
	import com.newgonzo.web.css.properties.LengthManager;
	import com.newgonzo.web.css.values.css3.CSS3Values;

	public class FontSizeManager extends LengthManager
	{
		protected static const VALID_IDENTIFIERS:Array = 
		[
			CSS3Values.XX_SMALL,
			CSS3Values.X_SMALL,
			CSS3Values.SMALL,
			CSS3Values.MEDIUM,
			CSS3Values.LARGE,
			CSS3Values.X_LARGE,
			CSS3Values.XX_LARGE,
			CSS3Values.SMALLER,
			CSS3Values.LARGER
		];
		
		public function FontSizeManager()
		{
			super(FontProperties.FONT_SIZE, CSS3Values.MEDIUM_VALUE, true, VALID_IDENTIFIERS);
		}
	}
}