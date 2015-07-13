package com.newgonzo.web.css.properties.css3.borders
{
	import com.newgonzo.web.css.properties.IdentifierManager;
	import com.newgonzo.web.css.values.css3.CSS3Values;

	public class BorderStyleManager extends IdentifierManager
	{
		protected static const VALID_IDENTIFIERS:Array = 
		[
			CSS3Values.NONE,
			CSS3Values.HIDDEN,
			CSS3Values.DOTTED,
			CSS3Values.DASHED,
			CSS3Values.SOLID,
			CSS3Values.DOUBLE,
			CSS3Values.GROOVE,
			CSS3Values.RIDGE,
			CSS3Values.INSET,
			CSS3Values.OUTSET
		];
		
		public function BorderStyleManager(propertyName:String)
		{
			super(propertyName, CSS3Values.NONE_VALUE, false, VALID_IDENTIFIERS);
		}
	}
}