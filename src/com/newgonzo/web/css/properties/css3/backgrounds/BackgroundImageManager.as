package com.newgonzo.web.css.properties.css3.backgrounds
{
	import com.newgonzo.web.css.properties.IdentifierManager;
	import com.newgonzo.web.css.values.css3.CSS3Values;
	
	import org.w3c.css.sac.ILexicalUnit;
	import org.w3c.css.sac.LexicalUnitTypes;

	public class BackgroundImageManager extends IdentifierManager
	{
		protected static const VALID_IDENTIFIERS:Array = 
		[
			CSS3Values.NONE
		];
		
		public function BackgroundImageManager()
		{
			super(BackgroundProperties.BACKGROUND_IMAGE, CSS3Values.NONE_VALUE, false, VALID_IDENTIFIERS);
		}
		
		override public function acceptsValue(propertyValue:ILexicalUnit):Boolean
		{
			return super.acceptsValue(propertyValue) || propertyValue.type == LexicalUnitTypes.SAC_URI;
		}
	}
}