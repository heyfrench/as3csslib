package com.newgonzo.web.css.values
{
	import org.w3c.css.sac.ILexicalUnit;
	import org.w3c.css.sac.LexicalUnitTypes;
	
	public class FunctionValue extends AbstractValue
	{
		protected var name:String;
		protected var args:Array;
		
		public function FunctionValue(primitiveType:uint, functionName:String = "", functionArguments:Array = null)
		{
			super(primitiveType);
			name = functionName;
			args = functionArguments;
		}
		
		override public function toCSSString():String
		{
			var arg:IValue;
			var argValues:Array = new Array();
			
			for each(arg in args)
			{
				argValues.push(arg.toCSSString());
			}
			
			return name + "(" + argValues.join(", ") + ")";
		}
	}
}