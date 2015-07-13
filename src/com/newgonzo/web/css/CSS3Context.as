package com.newgonzo.web.css
{
	import com.newgonzo.web.css.properties.css3.backgrounds.BackgroundModule;
	import com.newgonzo.web.css.properties.css3.borders.BorderModule;
	import com.newgonzo.web.css.properties.css3.box.BoxModule;
	import com.newgonzo.web.css.properties.css3.color.ColorModule;
	import com.newgonzo.web.css.properties.css3.fonts.FontModule;
	import com.newgonzo.web.css.properties.css3.text.TextModule;
	import com.newgonzo.web.css.views.ICSSView;

	public class CSS3Context extends CSSContext
	{
		public function CSS3Context(defaultCSSView:ICSSView=null, objectFactory:ICSSFactory=null)
		{
			super(defaultCSSView, objectFactory);
			
			addPropertyManagers(ColorModule.PROPERTY_MANAGERS);
			addPropertyManagers(BackgroundModule.PROPERTY_MANAGERS);
			addPropertyManagers(BorderModule.PROPERTY_MANAGERS);
			addPropertyManagers(FontModule.PROPERTY_MANAGERS);
			addPropertyManagers(TextModule.PROPERTY_MANAGERS);
			addPropertyManagers(BoxModule.PROPERTY_MANAGERS);
		}
	}
}