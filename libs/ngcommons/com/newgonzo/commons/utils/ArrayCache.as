package com.newgonzo.commons.utils
{
	public class ArrayCache
	{
		private var newItems:Array;
		private var currentItems:Array;
		private var oldItems:Array;
		
		public function ArrayCache(initItems:Array = null)
		{
			if(initItems)
			{
				this.currentItems = initItems;
			}
			else
			{
				this.currentItems = new Array();
			}		
		}
		
		public function set items(items:Array):void
		{
			this.newItems = new Array();
			this.oldItems = new Array();
			
			var newCurrentItems:Array = new Array();
			
			var item:*;
			var idx:Number;
			
			for each(item in items)
			{
				idx = this.currentItems.indexOf(item);
				
				if(idx == -1)
				{
					// item never existed and is new
					this.newItems.push(item);
				}
				else
				{
					// remove from currentItems so it doesn't get
					// identified as an old item and push into the
					// temporary new current items
					newCurrentItems.push(item);
					this.currentItems.splice(idx, 1);
				}
			}
			
			// what's left of the current items that didn't make it into
			// the new cache become the old items
			this.oldItems = this.currentItems;
			
			// current items now reflect the new cache
			this.currentItems = newCurrentItems;
		}
		
		public function get items():Array
		{
			return this.currentItems;
		}
		
		public function get entering():Array
		{
			return this.newItems;
		}
		
		public function get exiting():Array
		{
			return this.oldItems;
		}
		
		/**
		 * Setting the exiting array is the same as setting the "items"
		 * value to be all of the current items that aren't in the exiting array		 */
		public function set exiting(items:Array):void
		{
			var notExitingItems:Array = new Array();
			var item:*;
			var idx:Number;
			
			for each(item in this.currentItems)
			{
				if(items.indexOf(item) == -1)
				{
					// it's not in the exiting array, so it goes into the not exiting array
					notExitingItems.push(item);
				}
			}
			
			// set items as teh ones that aren't leaving.  the rest will get
			// funneled into the exiting var
			this.items = notExitingItems;
		}
		
		public function clear():void
		{
			this.newItems = new Array();
			this.currentItems = new Array();
			this.oldItems = new Array();
		}
	}
}