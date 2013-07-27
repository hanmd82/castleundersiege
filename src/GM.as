package
{
	import flash.system.Capabilities;
	import flash.utils.getTimer;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	import towers.Tower;
	import towers.TowerAttributeSet;

	/**
	 * Game Master
	 * static class for centralized game logic
	 * used to store all game objects and thus can be used like a database as well
	 */
	public class GM
	{
		public static const tileWidth:int = 32;
		public static const tileHeight:int = 32;
		public static const gridNumCellsX:int = 20;
		public static const gridNumCellsY:int = 15;
		public static var grid:Array;
		public static var root:DisplayObjectContainer;
		public static var totalElapsedMS:Number;
		public static var elapsedMS:Number;
		
		// assets manager
		public static var assets:AssetManager;
		
		// towers		
		private static var towers:Array;
		private static var tower_attribute_sets:Array;
		
		// enemies
		
		// waves
		
		public function GM()
		{
		}
		
		public static function appInit():void
		{
			assets = new AssetManager();
			assets.verbose = Capabilities.isDebugger;
			assets.enqueue(EmbeddedAssets);
		}
		
		public static function gameInit(newRoot:DisplayObjectContainer):void
		{
			//assets.addTextureAtlas("spritesheet", new TextureAtlas(assets.getTexture("spritesheet"), 
			
			root = newRoot;
			root.addEventListener(Event.ENTER_FRAME, gameUpdate);
			totalElapsedMS = getTimer();
			
			// define tower attributes
			towers = new Array();
			tower_attribute_sets = new Array();
			
			tower_attribute_sets.add(new TowerAttributeSet(Tower.TYPE_GUARD,  Tower.ATTACK_DAMAGE_LIGHT, Tower.ATTACK_RANGE_NEAR, Tower.ATTACK_INTERVAL_MEDIUM));
			tower_attribute_sets.add(new TowerAttributeSet(Tower.TYPE_ARCHER, Tower.ATTACK_DAMAGE_LIGHT, Tower.ATTACK_RANGE_FAR,  Tower.ATTACK_INTERVAL_MEDIUM));
			tower_attribute_sets.add(new TowerAttributeSet(Tower.TYPE_CANNON, Tower.ATTACK_DAMAGE_HEAVY, Tower.ATTACK_RANGE_NEAR, Tower.ATTACK_INTERVAL_SLOW));
			tower_attribute_sets.add(new TowerAttributeSet(Tower.TYPE_FROST,  Tower.ATTACK_DAMAGE_LIGHT, Tower.ATTACK_RANGE_NEAR, Tower.ATTACK_INTERVAL_SLOW));
			
			
			// test drawing
			
//			var tf:TextField = new TextField(500, 300, "hello world");
//			root.addChild(tf);
			
			// tile texture
			var tileTex:Texture = assets.getTexture("tile");
			
			// set up grid
			grid = new Array(gridNumCellsX);
			for(var x:int = 0; x < gridNumCellsX; x++)
			{
				grid[x] = new Array(gridNumCellsY);
				for(var y:int = 0; y < gridNumCellsY; y++)
				{
					//grid[x][y]
					var tileImg:Image = new Image(tileTex);
					tileImg.x = x*tileWidth;
					tileImg.y = y*tileHeight;
					root.addChild(tileImg);
				}
			}
			// draw grid
			
			
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