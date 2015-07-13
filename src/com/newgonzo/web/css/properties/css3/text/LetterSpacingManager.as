package com.newgonzo.web.css.properties.css3.text
{
	import com.newgonzo.web.css.properties.LengthManager;
	import com.newgonzo.web.css.values.css3.CSS3Values;

	public class LetterSpacingManager extends LengthManager
	{
		protected static const VALID_IDENTIFIERS:Array = 
		[
			CSS3Values.NORMAL
		];
		
		public function LetterSpacingManager()
		{
			super(TextProperties.LETTER_SPACING, CSS3Values.NORMAL_VALUE, true, VALID_IDENTIFIERS);
		}
		
	}
}