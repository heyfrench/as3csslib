package com.newgonzo.web.css
{
	import com.newgonzo.web.css.views.ICSSView;
	
	import org.w3c.css.sac.CSSError;
	
	public class CSS
	{
		public static var defaultContext:ICSSContext = new CSSContext();
		
		protected var cssContext:ICSSContext;
		protected var styleSelector:ICSSStyleSelector;
		
		public function CSS(source:String = null, context:ICSSContext = null)
		{
			cssContext = context ? context : defaultContext;
			if(!cssContext) throw new CSSError("A CSS context must be defined.");
			
			styleSelector = createCSSStyleSelector();
			if(source) parse(source);
		}
		
		public function get context():ICSSContext
		{
			return cssContext;
		}
		
		public function get selector():ICSSStyleSelector
		{
			return styleSelector;
		}
		
		public function get errors():Array
		{
			var cssErrors:Array = new Array();
			var documents:Array = styleSelector.documents;
			var document:ICSSDocument;
			
			for each(document in documents)
			{
				cssErrors = cssErrors.concat(document.errors);
			}
			
			return cssErrors;
		}
		
		public function get warnings():Array
		{
			var cssWarnings:Array = new Array();
			var documents:Array = styleSelector.documents;
			var document:ICSSDocument;
			
			for each(document in documents)
			{
				cssWarnings = cssWarnings.concat(document.warnings);
			}
			
			return cssWarnings;
		}
		
		public function parse(css:String, uri:String = null, origin:int = -1):ICSSDocument
		{
			var doc:ICSSDocument = cssContext.factory.createDocument(cssContext, uri, origin);
			styleSelector.addDocument(doc);
			doc.parseCSS(css);
			
			return doc;
		}
		
		public function style(node:*):CSSComputedStyle
		{
			var view:ICSSView = cssContext.getView(node);
			return styleSelector.getComputedStyle(view, node);
		}
		
		/**
		 * Returns the array of nodes that have matching styles.
		 */
		public function select(node:*):Array
		{
			var results:Array = new Array();
			var view:ICSSView = cssContext.getView(node);
			
			if(matchNode(node, view))
			{
				results.push(node);
			}
			
			addMatchingChildren(node, view, results);
			return results;
		}
		
		public function clear():void
		{
			styleSelector = createCSSStyleSelector();
		}
		
		public function toString():String
		{
			return toCSSString();
		}
		
		public function toCSSString():String
		{
			var document:ICSSDocument;
			var cascade:Array = styleSelector.documents;
			var css:String = "";
			
			for each(document in cascade)
			{
				css += document.toCSSString() + "\n";
			}
			
			return css;
		}
		
		protected function createCSSStyleSelector():ICSSStyleSelector
		{
			return new CSSStyleSelector();
		}
		
		protected function addMatchingChildren(node:*, view:ICSSView, target:Array):void
		{
			var numChildren:int = view.numChildren(node);
			
			if(numChildren == 0)
			{
				return;
			}
			
			var child:*;
			var i:int = 0;
			
			for(; i<numChildren; i++)
			{
				child = view.child(node, i);
				
				if(matchNode(node, view))
				{
					target.push(child);
				}
				
				addMatchingChildren(child, view, target);
			}
		}
		
		protected function matchNode(node:*, view:ICSSView):Boolean
		{
			return styleSelector.getMatchingRules(view, node).length > 0;
		}
	}
}