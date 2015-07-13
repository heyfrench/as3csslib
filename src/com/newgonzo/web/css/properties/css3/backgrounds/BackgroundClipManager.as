package com.newgonzo.web.css.properties.css3.backgrounds
{
	import com.newgonzo.web.css.properties.IdentifierManager;
	import com.newgonzo.web.css.values.css3.CSS3Values;

	public class BackgroundClipManager extends IdentifierManager
	{
		protected static const VALID_IDENTIFIERS:Array = 
		[
			CSS3Values.BORDER_BOX,
			CSS3Values.PADDING_BOX
		];
		
		public function BackgroundClipManager()
		{
			super(BackgroundProperties.BACKGROUND_CLIP, CSS3Values.BORDER_BOX_VALUE, false, VALID_IDENTIFIERS);
		}
		
	}
}