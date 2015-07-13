package com.newgonzo.web.css.properties.css3.box
{
	public class BoxModule
	{
		public static const PROPERTY_MANAGERS:Array = 
		[
			// padding
			new PaddingShorthand(),
			new PaddingManager(BoxProperties.PADDING_TOP),
			new PaddingManager(BoxProperties.PADDING_RIGHT),
			new PaddingManager(BoxProperties.PADDING_BOTTOM),
			new PaddingManager(BoxProperties.PADDING_LEFT),
			
			// margin
			new MarginShorthand(),
			new MarginManager(BoxProperties.MARGIN_TOP),
			new MarginManager(BoxProperties.MARGIN_RIGHT),
			new MarginManager(BoxProperties.MARGIN_BOTTOM),
			new MarginManager(BoxProperties.MARGIN_LEFT)
		];
	}
}