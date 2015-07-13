package org.w3c.dom.html
{
	public interface IHTMLInputElement extends IHTMLElement
	{
		function get form():IHTMLFormElement
		
		function get defaultValue():String
		//public void setDefaultValue(String defaultValue);
		
		function get defaultChecked():Boolean
		//public void setDefaultChecked(boolean defaultChecked);
		
		function get accept():String
		//public void setAccept(String accept);
		
		function get accessKey():String
		//public void setAccessKey(String accessKey);
		
		function get align():String
		//public void setAlign(String align);
		
		function get alt():String
		//public void setAlt(String alt);
		
		function get checked():Boolean
		//public void setChecked(boolean checked);
		
		function get disabled():Boolean
		function set disabled(value:Boolean):void
		
		function get maxLength():int
		//public void setMaxLength(int maxLength);
		
		function get name():String
		//public void setName(String name);
		
		function get readOnly():Boolean
		//public void setReadOnly(boolean readOnly);
		
		function get size():int
		//public void setSize(int size);
		
		function get src():String
		//public void setSrc(String src);
		
		function get tabIndex():int
		//public void setTabIndex(int tabIndex);
		
		function get type():String
		//public void setType(String type);
		
		function get useMap():String
		//public void setUseMap(String useMap);
		
		function get value():String
		//public void setValue(String value);
		
		//function blur():void
		//function focus():void
		//function select():void
		//function click():void
	}
}
