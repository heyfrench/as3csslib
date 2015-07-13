package com.newgonzo.web.css.selectors
{
	import com.newgonzo.web.css.views.ICSSView;
	
	import org.w3c.css.sac.ConditionTypes;
	import org.w3c.css.sac.IAttributeCondition;	

	public class PseudoClassCondition extends AbstractFunctionCondition implements IExtendedCondition, IAttributeCondition
	{		
		registerFunctions();
		
		public function PseudoClassCondition(localName:String, namespaceURI:String, args:Array=null)
		{
			super(localName, namespaceURI, args);
		}
		
		protected static function registerFunctions():void
		{
			functionMap["only-child"] = onlyChild;
			functionMap["only-of-type"] = onlyOfType;
			functionMap["root"] = root;
			functionMap["first-child"] = firstChild;
			functionMap["last-child"] = lastChild;
			functionMap["first-of-type"] = firstOfType;
			functionMap["last-of-type"] = lastOfType;
			functionMap["empty"] = empty;
			functionMap["contains"] = contains;
			
			functionMap["nth-child"] = nthChild;
			functionMap["nth-of-type"] = nthOfType;
			functionMap["nth-last-child"] = nthLastChild;
			functionMap["nth-last-of-type"] = nthLastOfType;

			argumentMap["nth-child"] = parseNth;
			argumentMap["nth-of-type"] = parseNth;
			argumentMap["nth-last-child"] = parseNth;
			argumentMap["nth-last-of-type"] = parseNth;
		}
		
		protected static function root(view:ICSSView, node:*):Boolean
		{
			return view.parent(node) == null;
		}
		
		protected static function empty(view:ICSSView, node:*):Boolean
		{
			return view.textContent(node).length == 0 && view.numChildren(node) == 0;
		}
		
		protected static function contains(view:ICSSView, node:*, value:String):Boolean
		{
			return view.textContent(node).indexOf(value) != -1;
		}
		
		protected static function firstChild(view:ICSSView, node:*):Boolean
		{
			return view.parent(node) && view.childIndex(node) == 0;
		}
		
		protected static function lastChild(view:ICSSView, node:*):Boolean
		{
			return view.parent(node) && view.childIndex(node) == view.numChildren(view.parent(node)) - 1;
		}
		
		protected static function firstOfType(view:ICSSView, node:*):Boolean
		{
			return view.parent(node) && getNthType(view, node) == 1;
		}
		
		protected static function lastOfType(view:ICSSView, node:*):Boolean
		{
			return view.parent(node) && getNthLastType(view, node) == 1;
		}
		
		protected static function onlyChild(view:ICSSView, node:*):Boolean
		{
			return view.parent(node) && view.numChildren(view.parent(node)) == 1;
		}
		
		protected static function onlyOfType(view:ICSSView, node:*):Boolean
		{
			return view.parent(node) && countType(view, node) == 1;
		}
		
		/*
		* Nth Child Functions
		*/
		
		protected static function nthChild(view:ICSSView, node:*, offset:int, multiple:int):Boolean
		{
			return view.parent(node) && matchNth(view.childIndex(node) + 1, offset, multiple);
		}
		
		protected static function nthOfType(view:ICSSView, node:*, offset:int, multiple:int):Boolean
		{
			return view.parent(node) && matchNth(getNthType(view, node), offset, multiple);
		}
		
		protected static function nthLastChild(view:ICSSView, node:*, offset:int, multiple:int):Boolean
		{
			return view.parent(node) && matchNth(view.numChildren(view.parent(node)) - view.childIndex(node), offset, multiple);
		}
		
		protected static function nthLastOfType(view:ICSSView, node:*, offset:int, multiple:int):Boolean
		{
			return view.parent(node) && matchNth(getNthLastType(view, node), offset, multiple);
		}
		
		protected static function countType(view:ICSSView, node:*):int
		{
			var localName:String = view.localName(node);
			var count:int = 0;
			var parent:* = view.parent(node);
			var i:int = view.numChildren(parent);
			
			var child:*;
			
			while(i--)
			{
				child = view.child(parent, i);
				
				if(view.localName(child) == localName)
				{
					count++;
				}
			}
			
			return count;
		}
		
		protected static function getNthType(view:ICSSView, node:*):int
		{
			var localName:String = view.localName(node);
			var childIndex:int = view.childIndex(node);
			var i:int = 0;
			var count:int = 0;
			var parent:* = view.parent(node);
			var child:*;
			
			for(; i<childIndex; i++)
			{
				child = view.child(parent, i);
				
				// type = localName
				if(view.localName(child) == localName)
				{
					count++;
				}
			}
			
			return count + 1;
		}
		
		protected static function getNthLastType(view:ICSSView, node:*):int
		{
			var localName:String = view.localName(node);
			var childIndex:int = view.childIndex(node);
			var parent:* = view.parent(node);
			var i:int = view.numChildren(parent) - 1;
			var count:int = 0;
			var child:*;
			
			for(; i>childIndex; i--)
			{
				child = view.child(parent, i);
				
				// type = localName
				if(view.localName(child) == localName)
				{
					count++;
				}
			}
			
			return count + 1;
		}
		
		// a helper function for parsing nth-arguments
		protected static function parseNth(argument:String):Array
		{    
			var offset:int = 0;
			var multiple:int = 0;
			
			if (argument == "odd")
			{
				multiple = 2;
				offset = 1;
			}
			else if (argument == "even")
			{
				multiple = 2;
				offset = 0;
			}
			else
			{
				var n:int = argument.indexOf("n");
				
				if (n != -1)
				{
					if (argument.charAt(0) == '-')
					{
						if (n == 1)
						{
							multiple = -1; // -n == -1n
						}
						else
						{
							multiple = parseInt(argument.substring(0, n));
						}
					}
					else if (n == 0)
					{
						multiple = 1; // n == 1n
					}
					else
					{
						multiple = parseInt(argument.substring(0, n))
					}
				
					var p:int = argument.indexOf("+", n);
					
					if (p != -1)
					{
						offset = parseInt(argument.substr(p + 1));
					}
					else
					{
						p = argument.indexOf("-", n);
						
						if(p != -1)
						{
							offset = -parseInt(argument.substr(p + 1));
						}
					}
				}
				else
				{
					offset = parseInt(argument);
				}
			}
			
			return [offset, multiple];
		}
		
		// a helper function for checking nth-arguments
		protected static function matchNth(count:int, offset:int = 0, multiple:int = 0):Boolean
		{
			if (!multiple)
			{
				return count == offset;
			}
			else if (multiple > 0)
			{
				if (count < offset)
				{
					return false;
				}
				
				return (count - offset) % multiple == 0;
			}
			else
			{
				if (count > offset)
				{
					return false;
				}
			
				return (offset - count) % (-multiple) == 0;
			}
		}
		
		override public function get conditionType():int
		{
			return ConditionTypes.SAC_PSEUDO_CLASS_CONDITION;
		}
	}
}