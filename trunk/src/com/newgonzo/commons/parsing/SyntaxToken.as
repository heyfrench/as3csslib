package com.newgonzo.commons.parsing
{
	
	public class SyntaxToken extends Token
	{
		private var tokenChildren:Array;
		private var tokenParent:SyntaxToken;
		
		public function SyntaxToken(type:int, value:String, sourceIndex:int, children:Array)
		{
			super(type, value, sourceIndex);

			var child:SyntaxToken;
						
			for each(child in children)
			{
				child.parent = this;
			}
		}
		
		public function set parent(value:SyntaxToken):void
		{
			tokenParent = value;	
		}
		
		public function get parent():SyntaxToken
		{
			return tokenParent;
		}
		
		public function get children():Array
		{
			return tokenChildren;
		}
	}
}