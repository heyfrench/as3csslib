package com.newgonzo.web.css.values
{
	import com.newgonzo.web.css.ICSSDocumentNode;
	
	import org.w3c.dom.css.ICSSPrimitiveValue;
	import org.w3c.dom.css.ICSSValueList;

	public interface IValue extends ICSSPrimitiveValue, ICSSValueList, ICSSDocumentNode
	{
	}
}