package
{
	import com.newgonzo.commons.css.CSSSelectorQuery;
	import com.newgonzo.commons.css.parser.CSSParser;
	import com.newgonzo.commons.css.sac.IDocumentHandler;
	import com.newgonzo.commons.css.sac.ISelectorList;
	import com.newgonzo.commons.io.*;
	
	import flash.utils.Dictionary;
	
	import mx.controls.TextArea;
	import mx.controls.Tree;
	import mx.core.Application;
	
	public class CSSTester extends Application implements IDocumentHandler
	{
		private var queue:LoaderQueue;
		
		private var xmlData:String;
		private var cssData:String;
		
		private var xml:XML;
		
		[Bindable] public var xmlStatus:String;
		[Bindable] public var cssStatus:String;
		
		public var xmlInput:TextArea;
		public var cssInput:TextArea;
		public var domTree:Tree;
		
		private var resultXml:XMLList;
		private var nodeStyles:Dictionary;
		
		
		public function CSSTester()
		{
		}
		
		public function startup():void
		{
			queue = new LoaderQueue();
		}
		
		[Bindable] 
		public function set cssContent(value:String):void
		{
			cssData = value;
		}
		
		public function get cssContent():String
		{
			return cssData;
		}
		
		[Bindable]
		public function set xmlContent(value:String):void
		{
			xmlData = value;
		}
		
		public function get xmlContent():String
		{
			return xmlData;
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
		
		public function updateXML():void
		{
			try
			{
				xml = new XML(xmlInput.text);
				xmlStatus = "XML OK";
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
			}
			
		}
		
		public function updateDOM():void
		{
			updateXML();
			updateCSS();
			
			nodeStyles = new Dictionary();
			
			// update view by resetting data provider
			domTree.dataProvider = resultXml;
		}
		
		protected function styleXML(xml:XML, props:Object):void
		{
			nodeStyles[xml] = props;
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
				if(result.parent())
				{
					domTree.expandItem(result.parent(), true);
				}
				
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