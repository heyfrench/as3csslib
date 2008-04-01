package
{
	import com.newgonzo.commons.css.CSSSelectorQuery;
	import com.newgonzo.commons.css.parser.CSSParser;
	import com.newgonzo.commons.css.sac.IDocumentHandler;
	import com.newgonzo.commons.css.sac.ISelectorList;
	
	import flash.utils.Dictionary;
	
	import mx.controls.Alert;
	import mx.controls.List;
	import mx.controls.TextArea;
	import mx.core.Application;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public class CSSTester extends Application implements IDocumentHandler
	{
		private var xmlData:String;
		private var cssData:String;
		
		private var xml:XML;
		
		[Bindable] public var xmlStatus:String;
		[Bindable] public var cssStatus:String;
		[Bindable] public var expectedStatus:String;
		[Bindable] public var testData:XMLList;
		[Bindable] public var testChanged:Boolean = false;
		[Bindable] public var testPassed:Boolean = false;
		
		[Bindable] public var xmlContent:String;
		[Bindable] public var cssContent:String;
		[Bindable] public var expectedResults:String;
		
		public var xmlInput:TextArea;
		public var cssInput:TextArea;
		public var resultsText:TextArea;
		public var expectedInput:TextArea;
		//public var domTree:Tree;
		public var testsService:HTTPService;
		public var testsList:List;
		
		private var resultXml:XMLList;
		private var nodeStyles:Dictionary;
		
		
		
		
		public function CSSTester()
		{
			XML.prettyIndent = 8;
		}
		
		public function startup():void
		{
			testsService.send();
		}
		
		public function testsReceived(event:ResultEvent):void
		{
			testData = event.result.test as XMLList;
		}
		
		public function testsFailed(event:FaultEvent):void
		{
			Alert.show("Failed to load test XML.");
		}
		
		public function testContentChanged():void
		{
			testChanged = true;
		}
		
		public function labelDomTreeItem(item:XML):String
		{		
			trace("labelDomTreeItem");
			var str:String = item.toXMLString();
			
			if(!str)
			{
				return item.toString();
			}
			
			var a:Array = str.match(/<[^>]*>/);
			
			if(!a)
			{
				return item.toString();
			}
			
			return a[0] as String;
		}
		
		public function updateTest():void
		{
			var xmlTest:XML = testsList.selectedItems[0] as XML;
			
			if(!xmlTest) return;
			
			//domTree.dataProvider = null;
			
			var xmlText:String = xmlTest.xml.text().toString();
			xmlText = xmlText.replace(/^[\s]*/, "").replace(/[\s]*$/, "");
			
			var cssText:String = xmlTest.css.text().toString();
			cssText = cssText.replace(/^[\s]*/, "").replace(/[\s]*$/, "");
			
			var expectedText:String = xmlTest.expected.text().toString();
			expectedText = expectedText.replace(/^[\s]*/, "").replace(/[\s]*$/, "");
			
			
			expectedInput.text = expectedText;
			xmlInput.text = xmlText;
			cssInput.text = cssText;
			
			updateDOM();
		}
		
		public function updateXML():void
		{
			try
			{
				xml = new XML(xmlInput.text);
				xmlStatus = "XML OK";
				
				xmlInput.text = xml.toXMLString();
			}
			catch(e:Error)
			{
					xmlStatus = e.message;
			}
		}
		
		public function updateCSS():void
		{
			try
			{		
				var parser:CSSParser = new CSSParser();
				parser.documentHandler = this;
				parser.parse(cssInput.text);
				cssStatus = "CSS OK";
			}
			catch(e:Error)
			{
				//Alert.show(e.getStackTrace());
				cssStatus = e.message;
				testPassed = false;	
			}
			
		}
		
		public function updateDOM():void
		{
			testChanged = false;
			
			updateXML();
			updateCSS();
			
			nodeStyles = new Dictionary();
			
			// update view by resetting data provider
			resultsText.text = resultXml.toXMLString();
			
			try
			{
				var expectedXml:XMLList = new XMLList(expectedInput.text);
				
				if(resultXml == expectedXml)
				{
					testPassed = true;
				}
				else
				{
					testPassed = false;
				}
				
				expectedInput.text = expectedXml.toXMLString();
			}
			catch(e:Error)
			{
				expectedStatus = e.message;
				testPassed = false;
			}
		}
		
		public function startDocument(source:String):void
		{
			trace("=========================== Start document " + source + " ===========================");
			
			resultXml = new XMLList();
		}
		
		public function endDocument(source:String):void
		{
			trace("=========================== End document " + source + " ===========================");
		}
		
		public function startSelector(selectors:ISelectorList):void
		{
			trace("=========================== Start selector " + selectors + " ===========================");
			
			if(!xml) return;
			
			var results:XMLList = CSSSelectorQuery.execQuery(selectors, xml);
			var result:XML;
			
			for each(result in results)
			{
				resultXml += result;
			}
			
			trace("=========================== Results (" + results.length() + ") ===========================");
			trace(results.toXMLString());
		}
		
		public function endSelector(selectors:ISelectorList):void
		{
			trace("=========================== End selector " + selectors + " ===========================");
		}
		
		public function property(name:String, value:Object, important:Boolean):void
		{
			trace("property(" + arguments + ")");
		}
		
		public function comment(source:String):void
		{
			trace("=========================== Comment: " + source + " ===========================");
		}
	}
}