package model
{
	import com.newgonzo.web.css.CSSComputedStyle;
	
	import org.w3c.dom.css.ICSSValue;
	
	[Bindable]
	public class CSSStyleTest
	{
		public var nodeName:String;
		public var styleName:String;
		public var expectedValue:*;
		public var actualValue:*;
		
		public var passed:Boolean = false;
		
		public function CSSStyleTest(testNode:CSSTestNode, styleAttr:XML, styles:CSSComputedStyle)
		{
			nodeName = testNode.name;
			
			if(styleAttr)
			{
				styleName = styleAttr.localName();
				expectedValue = styleAttr.toString();
				
				actualValue = styles.getComputedValue(styleName);
				
				trace("cssValue: " + styles.getComputedValue(styleName));
			}
			else
			{
				expectedValue = "Unstyled";
				actualValue = styles.length == 0 ? "Unstyled" : styles.length + " styles";
			}
		
			passed = expectedValue == actualValue;
		}

	}
}