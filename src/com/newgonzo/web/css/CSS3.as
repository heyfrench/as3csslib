package com.newgonzo.web.css
{
	public class CSS3 extends CSS
	{
		public static const defaultContext:ICSSContext = new CSS3Context();
		
		public function CSS3(source:String=null, context:ICSSContext=null)
		{
			super(source, context ? context : defaultContext);
		}
	}
}