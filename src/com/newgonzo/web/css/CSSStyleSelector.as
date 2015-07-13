package com.newgonzo.web.css
{

	import com.newgonzo.web.css.properties.CSSPriority;
	import com.newgonzo.web.css.rules.IStyleRule;
	import com.newgonzo.web.css.selectors.IExtendedSelector;
	import com.newgonzo.web.css.views.ICSSView;
	
	import org.w3c.css.sac.ISelectorList;
	import org.w3c.dom.css.*;
	
	public class CSSStyleSelector implements ICSSStyleSelector
	{
		private var unsortedDocuments:Array;
		private var sortedDocuments:Array;
		private var sortNeeded:Boolean = false;
		
		public function CSSStyleSelector()
		{
			unsortedDocuments = new Array();
			sortedDocuments = new Array();
		}
		
		public function get documents():Array
		{
			return unsortedDocuments;
		}
		public function set documents(value:Array):void
		{
			unsortedDocuments = value.concat();
			sortNeeded = true;
		}
		
		public function get cascade():Array
		{
			sortDocuments();
			return sortedDocuments.concat();
		}
		
		public function addDocument(document:ICSSDocument):ICSSDocument
		{
			unsortedDocuments.push(document);
			sortNeeded = true;
			return document;
		}
		
		public function removeDocument(document:ICSSDocument):ICSSDocument
		{
			var idx:int = unsortedDocuments.indexOf(document);
			
			if(idx != -1)
			{
				var removedDoc:ICSSDocument = unsortedDocuments.splice(idx, 1)[0] as ICSSDocument;
				sortNeeded = true;
				return removedDoc;
			}
			
			return null;
		}
		
		public function getComputedStyle(cssView:ICSSView, node:*, pseudoElement:String = null):CSSComputedStyle
		{
			var matchingRules:Array = getMatchingRules(cssView, node);
			
			/*
			if(!matchingRules.length)
			{
				return null;
			}
			*/
			// sort rules, placing highest specificities at the top
			sortRules(matchingRules);
			
			var styleRule:ICSSStyleRule;
			var styleMap:CSSStyleMap = new CSSStyleMap();
			
			// loop over rules, getting to highest specificity last
			// TODO: FIXME: linked lists throughout
			for each(styleRule in matchingRules)
			{
				mergeStyles(styleMap, styleRule.style);
			}
			
			return createComputedStyle(node, cssView, styleMap, pseudoElement);
		}
		
		public function getMatchingRules(cssView:ICSSView, node:*, pseudoElement:String = null):Array
		{
			var styleRules:Array = getStyleRules(cssView);
			var styleRule:IStyleRule;
			var selectors:ISelectorList;
			var selector:IExtendedSelector;
			
			//trace("styleRules: " + styleRules);
			
			var matchingRules:Array = new Array();
			
			for each(styleRule in styleRules)
			{
				selectors = styleRule.selectors;
				
				for each(selector in selectors)
				{
					if(selector.match(cssView, node))
					{
						matchingRules.push(styleRule);
						
						// only match one selector in the list
						break;
					}
				}
			}
			
			//trace("Matching rules; " + matchingRules);
			
			return matchingRules;
		}
		
		protected function getRuleSpecificity(rule:IStyleRule):uint
		{
			var selectors:ISelectorList = rule.selectors;
			var selector:IExtendedSelector;
			var highest:uint = 0;
			
			for each(selector in selectors)
			{
				if(selector.specificity > highest)
				{
					highest = selector.specificity;
				}
			}
			
			return highest;
		}
		
		protected function getStyleRules(cssView:ICSSView):Array
		{
			sortDocuments();
			
			var document:ICSSDocument;
			var styleSheet:ICSSStyleSheet;
			
			var rules:ICSSRuleList
			var rule:ICSSRule;
			var styleRule:ICSSStyleRule;
			
			var selectors:ISelectorList;
			var selector:IExtendedSelector;
			
			var matchingRules:Array = new Array();
			
			for each(document in sortedDocuments)
			{
				addStyleRules(cssView, document.styleSheet, matchingRules);
			}
			
			return matchingRules;
		}
		
		protected function addStyleRules(view:ICSSView, fromStyleSheet:ICSSStyleSheet, toArray:Array):void
		{
			var rules:ICSSRuleList = fromStyleSheet.cssRules;
			var rule:ICSSRule;
	
			for each(rule in rules)
			{
				switch(rule.type)
				{
					case CSSRuleTypes.STYLE_RULE:
						toArray.push(rule);
						break;
					
					case CSSRuleTypes.IMPORT_RULE:
						addStyleRules(view, (rule as ICSSImportRule).styleSheet, toArray);
						break;
						
					default:
						continue;
				}
			}
		}
		
		protected function mergeStyles(styleMap:CSSStyleMap, overrideStyles:ICSSStyleDeclaration):void
		{
			// TODO: Test me
			var numProps:uint;
			var propName:String;
			var important:Boolean;
			
			numProps = overrideStyles.length;
			
			while(numProps--)
			{
				propName = overrideStyles.item(numProps);
				
				// only override if the style isn't important.
				// if the override is important too, override
				important = overrideStyles.getPropertyPriority(propName) == CSSPriority.IMPORTANT;
				
				if(styleMap.getPropertyPriority(propName) == CSSPriority.IMPORTANT && !important)
				{
					continue;
				}
				
				// override property
				styleMap.setProperty(propName, overrideStyles.getPropertyCSSValue(propName), overrideStyles.getPropertyPriority(propName));
			}
		}
		
		protected function createComputedStyle(node:*, cssView:ICSSView, styleMap:ICSSStyleMap, pseudoElement:String = null):CSSComputedStyle
		{
			return new CSSComputedStyle(this, node, cssView, styleMap, pseudoElement);
		}
		
		protected function sortRules(rules:Array):void
		{
			rules.sort(ruleSortFunc);
		}
		
		private function ruleSortFunc(rule1:IStyleRule, rule2:IStyleRule):int
		{
			var spec1:uint = getRuleSpecificity(rule1);
			var spec2:uint = getRuleSpecificity(rule2);
			
			if(spec1 > spec2)
			{
				return 1;
			}
			
			if(spec1 < spec2)
			{
				return -1;
			}
			
			return 0;
		}
		
		private function sortDocuments(force:Boolean = false):void
		{
			if((sortNeeded || force) && unsortedDocuments)
			{
				sortedDocuments = unsortedDocuments.concat();
				sortedDocuments.sort(documentSortFunc);
				sortNeeded = false;
			}
		}
		
		private function documentSortFunc(doc1:ICSSDocument, doc2:ICSSDocument):int
		{
			var priority:int = CSSDocumentOrigin.compare(doc1.origin, doc2.origin);
			return doc1.origin == priority ? -1 : doc2.origin == priority ? 1 : 0;
		}
	}
}
