/*
	Copyright (c) 2007 Memorphic Ltd. All rights reserved.
	
	Redistribution and use in source and binary forms, with or without 
	modification, are permitted provided that the following conditions 
	are met:
	
		* Redistributions of source code must retain the above copyright 
		notice, this list of conditions and the following disclaimer.
	    	
	    * Redistributions in binary form must reproduce the above 
	    copyright notice, this list of conditions and the following 
	    disclaimer in the documentation and/or other materials provided 
	    with the distribution.
	    	
	    * Neither the name of MEMORPHIC LTD nor the names of its 
	    contributors may be used to endorse or promote products derived 
	    from this software without specific prior written permission.
	
	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
	"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
	LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
	A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT 
	OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
	SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT 
	LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, 
	DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY 
	THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
	OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

package memorphic.xpath.model
{
	final public class NodeTypes
	{
		public static const COMMENT:String = "comment";
		public static const TEXT:String = "text";
		public static const PROCESSING_INSTRUCTION:String = "processing-instruction";
		public static const NODE:String = "node";
		
		
		
		public static function isNodeType(test:String):Boolean
		{
			switch(test){
			case COMMENT: case TEXT:
			case PROCESSING_INSTRUCTION: case NODE:
				return true;
			default:
				return false;
			}
		}
		
		
		public static function xmlKindToNodeType(kind:String):String
		{
			// text, comment, processing-instruction, attribute, or element
			switch(kind){
			case COMMENT: case TEXT: case PROCESSING_INSTRUCTION:
				return kind;
			case "element":
				return NODE;
			default:
				// including "attribute" which is handled as an Axis in XPath
				throw new Error("cannot convert '" + kind + "' to an XPath NodeType");
			}
		}
		
	}
}