package com.newgonzo.web.css.properties.css3.color
{
	import com.newgonzo.web.css.properties.AbstractColorManager;
	import com.newgonzo.web.css.values.IValue;
	import com.newgonzo.web.css.values.css3.CSS3Values;

	public class ColorManager extends AbstractColorManager
	{
		protected static const VALID_IDENTIFIERS:Array = 
		[
			// TODO: Color name identifiers
			CSS3Values.TRANSPARENT
		];
		
		public function ColorManager(propertyName:String, defaultValue:IValue=null, isInherited:Boolean=false, validIdentifiers:Array=null)
		{
			var idents:Array = validIdentifiers ? VALID_IDENTIFIERS.concat(validIdentifiers) : VALID_IDENTIFIERS;
			super(propertyName, defaultValue, isInherited, idents);
		}
		
	}
}