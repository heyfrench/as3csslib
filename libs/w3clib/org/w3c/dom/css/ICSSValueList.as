package org.w3c.dom.css
{	
	public interface ICSSValueList extends ICSSValue
	{	
		function get length():int
		function item(index:int):ICSSValue
	}
}
