package com.newgonzo.web.css.properties.css3.fonts
{
	import com.newgonzo.web.css.properties.IdentifierManager;
	import com.newgonzo.web.css.values.css3.CSS3Values;
	
	import org.w3c.css.sac.ILexicalUnit;
	import org.w3c.css.sac.LexicalUnitTypes;

	public class FontWeightManager extends IdentifierManager
	{
		protected static const VALID_IDENTIFIERS:Array = 
		[
			CSS3Values.NORMAL,
			CSS3Values.BOLD,
			CSS3Values.BOLDER,
			CSS3Values.LIGHTER,
			CSS3Values.NUMBER_100,
			CSS3Values.NUMBER_200,
			CSS3Values.NUMBER_300,
			CSS3Values.NUMBER_400,
			CSS3Values.NUMBER_500,
			CSS3Values.NUMBER_600,
			CSS3Values.NUMBER_700,
			CSS3Values.NUMBER_800,
			CSS3Values.NUMBER_900
		];
		
		protected static const VALID_WEIGHTS:Array = 
		[
			CSS3Values.NUMBER_100,
			CSS3Values.NUMBER_200,
			CSS3Values.NUMBER_300,
			CSS3Values.NUMBER_400,
			CSS3Values.NUMBER_500,
			CSS3Values.NUMBER_600,
			CSS3Values.NUMBER_700,
			CSS3Values.NUMBER_800,
			CSS3Values.NUMBER_900
		];
		
		public function FontWeightManager()
		{
			super(FontProperties.FONT_WEIGHT, CSS3Values.NORMAL_VALUE, true, VALID_IDENTIFIERS);
		}
		
		override public function acceptsValue(propertyValue:ILexicalUnit):Boolean
		{
				return super.acceptsValue(propertyValue) || (propertyValue.type == LexicalUnitTypes.SAC_REAL) && (VALID_WEIGHTS.indexOf(propertyValue.integerValue) != -1);
		}
	}
}