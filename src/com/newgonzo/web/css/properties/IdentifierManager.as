package com.newgonzo.web.css.properties
{
	import com.newgonzo.web.css.values.IValue;
	
	import org.w3c.css.sac.ILexicalUnit;
	import org.w3c.css.sac.LexicalUnitTypes;

	public class IdentifierManager extends PropertyManager
	{
		protected var identifiers:Array;
		
		public function IdentifierManager(propertyName:String, defaultValue:IValue=null, isInherited:Boolean=false, validIdentifiers:Array=null)
		{
			super(propertyName, defaultValue, isInherited);
			identifiers = validIdentifiers ? validIdentifiers : getValidIdentifiers();
		}
		
		override public function acceptsValue(propertyValue:ILexicalUnit):Boolean
		{
			var type:int = propertyValue.type;
			
			if(type == LexicalUnitTypes.SAC_INHERIT)
			{
				return true;
			}
			
			if(identifiers)
			{
				return (type == LexicalUnitTypes.SAC_IDENT) && (identifiers.indexOf(propertyValue.stringValue) != -1)
			}
				
			return true;
		}
		
		protected function getValidIdentifiers():Array
		{
			return null;
		}
	}
}