package com.newgonzo.web.css.properties.css3.borders
{
	public class BorderModule
	{
		public static const PROPERTY_MANAGERS:Array = 
		[
			// border shorthands
			new BorderShorthand(),
			new BorderSideShorthand(BorderProperties.BORDER_TOP),
			new BorderSideShorthand(BorderProperties.BORDER_RIGHT),
			new BorderSideShorthand(BorderProperties.BORDER_BOTTOM),
			new BorderSideShorthand(BorderProperties.BORDER_LEFT),
			
			// border-color
			new BorderColorShorthand(),
			new BorderColorManager(BorderProperties.BORDER_TOP_COLOR),
			new BorderColorManager(BorderProperties.BORDER_RIGHT_COLOR),
			new BorderColorManager(BorderProperties.BORDER_BOTTOM_COLOR),
			new BorderColorManager(BorderProperties.BORDER_LEFT_COLOR),
			
			// border-style
			new BorderStyleShorthand(),
			new BorderStyleManager(BorderProperties.BORDER_TOP_STYLE),
			new BorderStyleManager(BorderProperties.BORDER_RIGHT_STYLE),
			new BorderStyleManager(BorderProperties.BORDER_BOTTOM_STYLE),
			new BorderStyleManager(BorderProperties.BORDER_LEFT_STYLE),
			
			// border-width
			new BorderWidthShorthand(),
			new BorderWidthManager(BorderProperties.BORDER_TOP_WIDTH),
			new BorderWidthManager(BorderProperties.BORDER_RIGHT_WIDTH),
			new BorderWidthManager(BorderProperties.BORDER_BOTTOM_WIDTH),
			new BorderWidthManager(BorderProperties.BORDER_LEFT_WIDTH),
			
			// border-radius
			new BorderRadiusShorthand(),
			new BorderRadiusManager(BorderProperties.BORDER_TOP_LEFT_RADIUS),
			new BorderRadiusManager(BorderProperties.BORDER_TOP_RIGHT_RADIUS),
			new BorderRadiusManager(BorderProperties.BORDER_BOTTOM_LEFT_RADIUS),
			new BorderRadiusManager(BorderProperties.BORDER_BOTTOM_RIGHT_RADIUS)
		];
	}
}