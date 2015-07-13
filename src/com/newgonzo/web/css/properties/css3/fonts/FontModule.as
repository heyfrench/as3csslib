package com.newgonzo.web.css.properties.css3.fonts
{
	public class FontModule
	{
		public static const PROPERTY_MANAGERS:Array = 
		[
			// font
			new FontShorthand(),
			new FontStyleManager(),
			new FontVariantManager(),
			new FontWeightManager(),
			new FontSizeManager(),
			new FontFamilyManager(),
			new LineHeightManager()
		];
	}
}