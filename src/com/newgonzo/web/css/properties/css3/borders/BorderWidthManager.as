package com.newgonzo.web.css.properties.css3.borders
{
	import com.newgonzo.web.css.properties.LengthManager;
	import com.newgonzo.web.css.values.css3.CSS3Values;

	public class BorderWidthManager extends LengthManager
	{
		protected static const VALID_IDENTIFIERS:Array = 
		[
			CSS3Values.THIN,
			CSS3Values.MEDIUM,
			CSS3Values.THICK
		];
		
		public function BorderWidthManager(propertyName:String)
		{
			super(propertyName, CSS3Values.MEDIUM_VALUE, false, VALID_IDENTIFIERS);
		}
	}
}