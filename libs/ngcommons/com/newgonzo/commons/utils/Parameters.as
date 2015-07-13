package com.newgonzo.commons.utils
{
	public class Parameters
	{
		private var params:Object;
		private var joined:Parameters;
		
		public function Parameters(paramsSource:Object = null, paramsJoined:Object = null)
		{
			params = paramsSource ? paramsSource : new Object();
			
			if(paramsJoined)
			{
				if(paramsJoined is Parameters)
				{
					joined = paramsJoined as Parameters;
				}
				else
				{
					joined = new Parameters(paramsJoined);
				}
			}
		}
		
		public function join(params:Parameters):Parameters
		{
			return new Parameters(this, params);
		}
		
		public function hasParam(name:String):Boolean
		{
			return findParam(name) != null;
		}
		
		public function getObject(name:String, defaultValue:Object = null):Object
		{
			return findParam(name);
		}
		
		public function getString(name:String, defaultValue:String = ""):String
		{
			var val:Object = findParam(name);
			
			if(val == null)
			{
				return defaultValue;
			}
			
			return val.toString();
		}
		
		public function getNumber(name:String, defaultValue:Number = NaN):Number
		{
			var val:Object = findParam(name);
			
			if(val == null)
			{
				return defaultValue;
			}
			
			return Number(val.toString());
		}
		
		public function getBoolean(name:String, defaultValue:Boolean = false):Boolean
		{
			var val:Object = findParam(name);
			
			if(val == null)
			{
				return defaultValue;
			}
			
			return val.toString().toLowerCase() == "true";
		}
		
		private function findParam(name:String):Object
		{
			var result:Object;
			
			if(params is Parameters)
			{
				result = (params as Parameters).getObject(name);
			}
			else
			{
				if(params.hasOwnProperty(name))
				{
					result = params[name];
				}
				else
				{
					var parts:Array = name.split(/\./s);
					var part:String;
					var obj:Object = params;
					var prop:String;
					var i:uint = 0;
					
					while(true)
					{
						part = parts.shift();
						
						if(!obj.hasOwnProperty(part))
						{
							break;
						}
						
						obj = obj[part];
						
						// last part
						if(!parts.length)
						{
							result = obj;
							break;
						}
					}
				}
			}
				
			if(result == null && joined)
			{
				result = joined.getObject(name);
			}
			
			return result;
		}
	}
}