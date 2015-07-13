package data
{
	public class CSSTestSet
	{
		public var tests:Array = new Array();
		
		public function CSSTestSet(xml:XML)
		{
			var test:XML;
			
			for each(test in xml.test)
			{
				tests.push(new CSSTest(test));
			}
		}
	}
}