package com.newgonzo.web.css.properties.css3.backgrounds
{
	import com.newgonzo.web.css.properties.IdentifierManager;
	import com.newgonzo.web.css.values.css3.CSS3Values;

	public class BackgroundOriginManager extends IdentifierManager
	{
		protected static const VALID_IDENTIFIERS:Array = 
		[
			CSS3Values.BORDER_BOX,
			CSS3Values.PADDING_BOX,
			CSS3Values.CONTENT_BOX
		];
		
		public function BackgroundOriginManager()
		{
			super(BackgroundProperties.BACKGROUND_ORIGIN, CSS3Values.PADDING_BOX_VALUE, false, VALID_IDENTIFIERS);
		}
		
	}
}