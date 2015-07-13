package com.newgonzo.web.css.properties.css3.fonts
{
	import com.newgonzo.web.css.properties.IdentifierManager;
	import com.newgonzo.web.css.values.css3.CSS3Values;

	public class FontVariantManager extends IdentifierManager
	{
		protected static const VALID_IDENTIFIERS:Array = 
		[
			CSS3Values.NORMAL,
			CSS3Values.SMALL_CAPS
		];
		
		public function FontVariantManager()
		{
			super(FontProperties.FONT_VARIANT, CSS3Values.NORMAL_VALUE, true, VALID_IDENTIFIERS);
		}
		
	}
}