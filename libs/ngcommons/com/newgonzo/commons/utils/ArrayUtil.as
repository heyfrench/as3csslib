/**
 * Static class of array utility methods 
 *
 * @author john
 */
package com.newgonzo.commons.utils
{
	public class ArrayUtil
	{
		/**
		 * Finds the first occurance of a value in an array
		 * 
		 * @param array The array to search
		 * @param value The object to search for
		 * 
		 * @return The index of the value if found, -1 if not found
		 */
		public static function indexOf(search:Array, value:Object):Number
		{
			/*
			for(var i:Number=0; i<search.length; i++)
			{
				if(search[i] == value)
				{
					return i;
				}
			}
			
			// if not found, return -1
			return -1;
			*/
			
			return search.indexOf(value);
		}
		
		
		/**
		 * Determines whether an element exists in an array
		 * 
		 * @param search The array to search for the value in
		 * @param value The value to search for
		 * 
		 * @return Boolean
		 */
		public static function contains(search:Array, value:Object):Boolean
		{
			if(ArrayUtil.indexOf(search, value) != -1)
			{
				return true;
			}
			
			return false;
		}
		
		/**
		 * Retrieves all array elements in search that do not exist in filter
		 * 
		 * @param search The array to filter values from
		 * @param filter The array of values to compare to
		 * 
		 * @return An array containing the values of search that don't exist in filter
		 */
		public static function diff(search:Array, filter:Array):Array
		{
			var aDiff:Array = new Array();
			
			for(var i:Number=0; i<search.length; i++)
			{
				if(!ArrayUtil.contains(filter, search[i]))
				{
					aDiff.push(search[i]);
				}
			}
			
			return aDiff;
		}
			
		/**
		 * Modifies an array to leave only unique entries.
		 * 
		 */
		public static function removeDuplicates(toModify:Array):void
		{		
			var seen:Array = new Array();
			
			for(var i:Number=0; i<toModify.length; i++)
			{
				if(ArrayUtil.indexOf(seen, toModify[i]) != -1)
				{
					// is a duplicate
					toModify.splice(i, 1);
					i--;
				}
				else
				{
					seen.push(toModify[i]);
				}
			}
		}
		
		/**
		 * Extracts items from an array and returns an array of the extractions
		 * 
		 * @param array Array to extract from
		 * @param value Value to extract
		 * 
		 * @return An array of the extractions, which will all be alike
		 */
		public static function extract(host:Array, value:Object):Array
		{		
			var a:Array = new Array();
			
			var n:Number;
			
			while((n = ArrayUtil.indexOf(host, value)) != -1)
			{
				a.push(host.splice(n, 1));
			}
			
			return a;
		}
		
		public static function clone(target:Array):Array
		{
			var a:Array = new Array();
			
			for(var i:Number=0; i<target.length; i++)
			{
				a[i] = target[i];
			}
			
			return a;
		}
	
		/**
		 * Shuffles an array
		 * 
		 * @param array Array to shuffle
		 * 
		 * @return the shuffled array
		 */
		public static function shuffle(host:Array):void
		{
			var nLen:Number = host.length;
			
			for (var i:Number=0; i<nLen; i++)
			{
				var nRand:Number = Math.floor(Math.random() * nLen);
			
				// Swap current index with a random one
				var oTemp:Object = host[i];
				host[i] = host[nRand];
				host[nRand] = oTemp;
			}
		}
	}
}