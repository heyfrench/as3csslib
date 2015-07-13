package data
{
	public class CSSTest
	{
		public var css:String;
		public var document:XML;
		
		public function CSSTest(xml:XML)
		{
			css = xml.css.text();
			document = new XML(xml.html[0].toXMLString());
		}
	}
}