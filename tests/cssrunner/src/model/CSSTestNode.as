package model
{
	import com.newgonzo.web.css.CSS;
	import com.newgonzo.web.css.CSSComputedStyle;
	
	[Bindable]
	public class CSSTestNode
	{
		public var node:XML;
		public var name:String;
		public var css:CSS;
		public var styles:CSSComputedStyle;
		
		public var styleTests:Array = new Array();
		
		public function CSSTestNode(node:XML, css:CSS)
		{
			this.node = node;
			this.css = css;
			this.name = node.localName();
			
			styles = css.style(node);
			
			var styleAttrs:XMLList = node.attributes();
			
			var attr:XML;
			var test:CSSStyleTest;
			
			for each(attr in styleAttrs)
			{
				if(attr.namespace() != stylens) continue;
				
				test = new CSSStyleTest(this, attr, styles);
				styleTests.push(test);
			}
			
			if(!styleTests.length)
			{
				test = new CSSStyleTest(this, null, styles);
				styleTests.push(test);
			}
		}
	}
}