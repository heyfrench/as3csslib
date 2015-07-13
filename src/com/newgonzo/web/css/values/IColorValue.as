package com.newgonzo.web.css.values
{
	public interface IColorValue extends IValue
	{
		function get rgb():int
		function get argb():uint
		function get opacity():Number
	}
}