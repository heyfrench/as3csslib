package com.newgonzo.web.css.selectors
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.views.ICSSView;
	
	import flash.utils.Dictionary;
	
	public class AbstractFunctionCondition extends AbstractAttributeCondition implements IExtendedCondition
	{
		protected static const argumentMap:Dictionary = new Dictionary();
		protected static const functionMap:Dictionary = new Dictionary();
		
		protected var args:Array;
		
		public function AbstractFunctionCondition(localName:String, namespaceURI:String, functionArguments:Array)
		{
			super(localName, namespaceURI, true, null);
			
			args = functionArguments;
		}
		
		public static function registerFunction(localName:String, functionHandler:Function, argumentHandler:Function = null):void
		{
			functionMap[localName] = functionHandler;
			argumentMap[localName] = argumentHandler;
		}
		
		public static function clearFunction(localName:String):void
		{
			delete functionMap[localName];
			delete argumentMap[localName];
		}
		
		override public function match(view:ICSSView, node:*):Boolean
		{
			try
			{
				var functionHandler:Function = functionMap[localName] as Function;
				var argumentHandler:Function = argumentMap[localName] as Function;
				
				if(functionHandler != null)
				{
					var parsedArgs:Array = argumentHandler != null ? argumentHandler.apply(null, args) as Array : args;
					
					if(!parsedArgs)
					{
						parsedArgs = [view, node];
					}
					else
					{
						parsedArgs = [view, node].concat(parsedArgs);
					}
					
					return functionHandler.apply(null, parsedArgs) as Boolean;
				}
				else
				{
					return view.isPseudoClass(node, localName);
				}
			}
			catch(e:Error)
			{
				
			}
			
			return false;
		}
		
		public function get conditionType():int
		{
			return ExtendedConditionTypes.FUNCTION_CONDITION;
		}
		
		public function toCSSString(document:ICSSDocument):String
		{
			if(args)
			{
				return ":" + localName + "(" + args + ")"
			}
			else
			{
				return ":" + localName;
			}
		}
	}
}