package com.newgonzo.web.css.properties.css3.backgrounds
{
	import com.newgonzo.web.css.properties.IdentifierManager;
	import com.newgonzo.web.css.values.css3.CSS3Values;

	public class BackgroundAttachmentManager extends IdentifierManager
	{
		protected static const VALID_IDENTIFIERS:Array = 
		[
			CSS3Values.SCROLL,
			CSS3Values.FIXED,
			CSS3Values.LOCAL
		];
		
		public function BackgroundAttachmentManager()
		{
			super(BackgroundProperties.BACKGROUND_ATTACHMENT, CSS3Values.SCROLL_VALUE, false, VALID_IDENTIFIERS);
		}
		
	}
}