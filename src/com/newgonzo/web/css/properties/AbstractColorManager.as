package com.newgonzo.web.css.properties
{
	import com.newgonzo.web.css.values.css3.CSS3Values;
	import com.newgonzo.web.css.values.IValue;
	
	import org.w3c.css.sac.ILexicalUnit;
	import org.w3c.css.sac.LexicalUnitTypes;

	public class AbstractColorManager extends IdentifierManager
	{
		public function AbstractColorManager(propertyName:String, defaultValue:IValue=null, isInherited:Boolean=false, validIdentifiers:Array=null)
		{
			super(propertyName, defaultValue, isInherited, validIdentifiers);
		}
		
		override public function acceptsValue(propertyValue:ILexicalUnit):Boolean
		{
			var type:int = propertyValue.type;
			
			switch(type)
			{
				case LexicalUnitTypes.SAC_RGBCOLOR:
				case LexicalUnitTypes.SAC_RGBACOLOR:
				case LexicalUnitTypes.SAC_HSLCOLOR:
				case LexicalUnitTypes.SAC_HSLACOLOR:
					return true
			}
			
			return super.acceptsValue(propertyValue);
		}
	}
}