package com.newgonzo.web.css.values
{
	import com.newgonzo.web.css.ICSSSerializable;
	
	import org.w3c.dom.css.CSSValueTypes;
	import org.w3c.dom.css.ICSSValue;
	
	public class ListValue extends AbstractValue
	{
		protected var listSeparator:String = ", ";
		protected var values:Array;
		
		public function ListValue(...initValues)
		{
			super();
			values = initValues ? initValues : new Array();
		}
		
		public function get separator():String
		{
			return listSeparator;
		}
		public function set separator(value:String):void
		{
			listSeparator = value;
		}
		
		override public function get length():int
		{
			return values.length;
		}
		
		override public function item(index:int):ICSSValue
		{
			return values[index] as ICSSValue;
		}
		
		override public function get cssValueType():int
		{
			return CSSValueTypes.CSS_VALUE_LIST;
		}
		
		public function append(value:ICSSValue):void
		{
			values.push(value);
		}
		
		override public function toCSSString():String
		{
			var value:ICSSSerializable;
			var list:Array = new Array();
			
			for each(value in values)
			{
				list.push(value.toCSSString());
			}
			
			return list.join(separator);
		}
	}
}