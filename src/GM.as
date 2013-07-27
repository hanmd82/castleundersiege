package
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.getTimer;

	/**
	 * Game Master
	 * static class for centralized game logic
	 * used to store all game objects and thus can be used like a database as well
	 */
	public class GM
	{
		public static var gridNumCellsX:int;
		public static var gridNumCellsY:int;
		public static var grid:Array;
		public static var root:DisplayObject;
		public static var totalElapsedMS:Number;
		public static var elapsedMS:Number;
		
		// towers
		
		
		// enemies
		
		// waves
		
		public function GM()
		{
		}
		
		public static function gameInit(newRoot:DisplayObject):void
		{
			// set up grid
			grid = new Array(gridNumCellsX);
			for(var x:int = 0; x < gridNumCellsX; x++)
			{
				grid[x] = new Array(gridNumCellsY);
			}
			
			root = newRoot;
			root.addEventListener(Event.ENTER_FRAME, gameUpdate);
			totalElapsedMS = getTimer();
		}
		
		public static function gameUpdate(evt:Event):void
		{
			// per frame
			var currMS:Number = getTimer();
			elapsedMS = currMS - totalElapsedMS;
			totalElapsedMS = currMS;
			
			// game logic
			
		}
		
		public static function gameEnd():void
		{
		}
	}
}