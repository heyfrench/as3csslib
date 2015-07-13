package com.newgonzo.web.css.properties.css3.fonts
{
	import com.newgonzo.web.css.properties.IdentifierManager;
	import com.newgonzo.web.css.values.css3.CSS3Values;

	public class FontStyleManager extends IdentifierManager
	{
		protected static const VALID_IDENTIFIERS:Array = 
		[
			CSS3Values.NORMAL, 
			CSS3Values.ITALIC, 
			CSS3Values.OBLIQUE
		];
		
		public function FontStyleManager()
		{
			super(FontProperties.FONT_STYLE, CSS3Values.NORMAL_VALUE, true, VALID_IDENTIFIERS);
		}
	}
}