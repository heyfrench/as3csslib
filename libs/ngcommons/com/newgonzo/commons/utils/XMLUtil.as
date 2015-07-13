
package com.newgonzo.commons.utils
{
	public class XMLUtil
	{
		public static function getRoot(node:XML):XML
		{
			var test:XML = node;
			var root:XML;
			
			while(test)
			{
				root = test;
				test = test.parent();
			}
			
			return root;
		}
		
		public static function isIdentical(xml1:XML, xml2:XML):Boolean
		{
			var p1:XML = xml1;
			var p2:XML = xml2;
			
			// XML equality check and then positional checks
			while(p1 != null && p2 != null)
			{
				if((p1 != p2) || (p1.childIndex() != p2.childIndex()))
				{
					return false;
				}
				
				p1 = p1.parent();
				p2 = p2.parent();
			}
			
			return true;
		}
	}
}