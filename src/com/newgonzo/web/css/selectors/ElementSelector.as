package com.newgonzo.web.css.selectors
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.views.ICSSView;
	
	import org.w3c.css.sac.IElementSelector;
	import org.w3c.css.sac.SelectorTypes;	

	public class ElementSelector implements IExtendedSelector, IElementSelector
	{
		private var ns:String;
		private var tag:String;
		
		public function ElementSelector(namespaceURI:String, tagName:String=null)
		{
			ns = namespaceURI;
			tag = tagName;
		}
		
		public function get specificity():uint
		{
			return localName == null ? 0 : 1;
		}
		
		public function get namespaceURI():String
		{
			return ns;
		}
		
		public function get localName():String
		{
			return tag;
		}
		
		public function match(view:ICSSView, node:*):Boolean
		{
			if(tag != null && !view.isType(node, tag))
			{
				return false;
			}
			
			var nodeNS:String = view.namespaceURI(node);
			
			if(ns != null)
			{
				if(ns.length == 0)
				{
					// empty string, explicitly NO namespace
					return nodeNS == null || nodeNS.length == 0;
				}
				else
				{
					return nodeNS == ns;
				}
			}
			
			return true;
		}
		
		public function get type():int
		{
			return SelectorTypes.SAC_ELEMENT_NODE_SELECTOR;
		}
		
		public function toCSSString(document:ICSSDocument):String
		{
			var elem:String = tag == null ? "*" : tag;
			
			var defaultNS:String = document.lookupNamespaceURI();
			var prefix:String;
			
			if(ns == "")
			{
				prefix = "";
			}
			else if(ns == "*")
			{
				prefix = defaultNS ? "*" : null;
			}
			else
			{
				prefix = document.lookupNamespacePrefix(ns);
			}
			
			return prefix != null ? prefix + "|" + elem : elem;
		}
	}
}