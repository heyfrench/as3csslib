package
{
	import data.CSSTestSet;
	
	import selectors.SelectorsSuite;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class CSSSuite
	{
		//public var suite1:ParserSuite;
		public var suite2:SelectorsSuite;
		
		public function CSSSuite(testSet:CSSTestSet)
		{
			trace("run CSSSuite with " + testSet);
		}

		
	}
}