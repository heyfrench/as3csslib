package com.newgonzo.web.css.properties.css3.box
{
	import com.newgonzo.web.css.properties.LengthManager;
	import com.newgonzo.web.css.values.css3.CSS3Values;

	public class MarginManager extends LengthManager
	{
		protected static const VALID_IDENTIFIERS:Array = 
		[
			CSS3Values.AUTO
		];
		
		public function MarginManager(propertyName:String)
		{
			super(propertyName, CSS3Values.ZERO_VALUE, false, VALID_IDENTIFIERS);
		}
	}
}