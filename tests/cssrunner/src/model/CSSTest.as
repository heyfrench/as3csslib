package model
{
	import com.newgonzo.web.css.CSS;
	import com.newgonzo.web.css.CSS3Context;
	
	[Bindable]
	public class CSSTest
	{
		public var description:String;
		
		public var cssSource:String;
		public var css:CSS;
		
		public var html:XML;
		public var testNodes:Array = new Array();
		
		public function CSSTest(source:XML)
		{
			description = source.description.text();
			
			cssSource = source.css.text();
			css = new CSS(cssSource, new CSS3Context());
			
			var htmlSource:String = source.html.toXMLString();
			
			// add namespace
			htmlSource.replace(/^<html/, "<html xmlns:style=\"" + stylens + "\"");
			html = new XML(htmlSource);
			
			var testNode:CSSTestNode;
			var htmlNodes:XMLList = html.descendants().(nodeKind() == "element");
			var htmlNode:XML;
			
			// root first
			testNode = new CSSTestNode(html, css);
			testNodes.push(testNode);
			
			for each(htmlNode in htmlNodes)
			{
				testNode = new CSSTestNode(htmlNode, css);
				testNodes.push(testNode);
			}
		}
	}
}