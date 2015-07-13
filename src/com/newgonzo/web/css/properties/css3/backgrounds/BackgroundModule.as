package com.newgonzo.web.css.properties.css3.backgrounds
{
	public class BackgroundModule
	{
		public static const PROPERTY_MANAGERS:Array = 
		[
			// background
			new BackgroundShorthand(),
			new BackgroundImageManager(),
			new BackgroundPositionManager(),
			new BackgroundSizeManager(),
			new BackgroundRepeatManager(),
			new BackgroundAttachmentManager(),
			new BackgroundOriginManager(),
			new BackgroundClipManager(),
			new BackgroundColorManager()
		];
	}
}