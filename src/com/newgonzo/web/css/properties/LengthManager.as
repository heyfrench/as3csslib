package com.newgonzo.web.css.properties
{
	import com.newgonzo.web.css.values.IValue;
	
	import org.w3c.css.sac.ILexicalUnit;
	import org.w3c.css.sac.LexicalUnitTypes;

	public class LengthManager extends IdentifierManager
	{
		public function LengthManager(propertyName:String, defaultValue:IValue=null, isInherited:Boolean=false, validIdentifiers:Array=null)
		{
			var idents:Array = validIdentifiers ? validIdentifiers : new Array();
			super(propertyName, defaultValue, isInherited, idents);
		}
		
		override public function acceptsValue(propertyValue:ILexicalUnit):Boolean
		{
			var type:int = propertyValue.type;
			
			switch(type)
			{
				case LexicalUnitTypes.SAC_INTEGER:
				case LexicalUnitTypes.SAC_REAL:
				case LexicalUnitTypes.SAC_PERCENTAGE:
				case LexicalUnitTypes.SAC_EM:
				case LexicalUnitTypes.SAC_EX:
				case LexicalUnitTypes.SAC_PIXEL:
				case LexicalUnitTypes.SAC_CENTIMETER:
				case LexicalUnitTypes.SAC_MILLIMETER:
				case LexicalUnitTypes.SAC_INCH:
				case LexicalUnitTypes.SAC_POINT:
				case LexicalUnitTypes.SAC_PICA:
					return true;
			}
			
			return super.acceptsValue(propertyValue);
		}
	}
}