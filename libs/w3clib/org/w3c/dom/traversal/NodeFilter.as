package org.w3c.dom.traversal
{	
	public class NodeFilter
	{
		public static const FILTER_ACCEPT:uint = 1;
		public static const FILTER_REJECT:uint = 2;
		public static const FILTER_SKIP:uint = 3;
		
		public static const SHOW_ALL:int = int(0xFFFFFFFF);
		public static const SHOW_ELEMENT:int = int(0x00000001);
		public static const SHOW_ATTRIBUTE:int = int(0x00000002);
		public static const SHOW_TEXT:int = int(0x00000004);
		public static const SHOW_CDATA_SECTION:int = int(0x00000008);
		public static const SHOW_ENTITY_REFERENCE:int = int(0x00000010);
		public static const SHOW_ENTITY:int = int(0x00000020);
		public static const SHOW_PROCESSING_INSTRUCTION:int = int(0x00000040);
		public static const SHOW_COMMENT:int = int(0x00000080);
		public static const SHOW_DOCUMENT:int = int(0x00000100);
		public static const SHOW_DOCUMENT_TYPE:int = int(0x00000200);
		public static const SHOW_DOCUMENT_FRAGMENT:int = int(0x00000400);
		public static const SHOW_NOTATION:int = int(0x00000800);
	 
	}
}