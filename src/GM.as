package
{
	import flash.geom.Point;
	import flash.system.Capabilities;
	import flash.utils.getTimer;
	
	import enemy.Enemy;
	import enemy.EnemyLight;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	import tower.Tower;
	import tower.TowerLongbow;

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
		public static var layerBG:Sprite;
		public static var layerGame:Sprite;
		public static var layerUI:Sprite;
		
		public static var totalElapsedMS:Number;
		public static var elapsedMS:Number;
		
		// assets manager
		public static var assets:AssetManager;
		
		// touch input (only one button for now)
		public static var touchPos:Point = new Point();
		public static var isTouching:Boolean = false;
		
		// TILE
		public static var prevTouchedTile:Image;
		public static var prevTouchedGX:int;
		public static var prevTouchedGY:int;
		public static const TILE_TINT_COLOR:uint = 0x993300;
		
		// towers		
		// TOWER ATTACK DATA
		public static const TOWER_ATTACK_DAMAGE_LIGHT:uint  = 10;
		public static const TOWER_ATTACK_DAMAGE_MEDIUM:uint = 20;
		public static const TOWER_ATTACK_DAMAGE_HEAVY:uint  = 30;

		public static const TOWER_ATTACK_RANGE_NEAR:uint    = 5;
		public static const TOWER_ATTACK_RANGE_MEDIUM:uint  = 10;
		public static const TOWER_ATTACK_RANGE_FAR:uint     = 20;

		public static const TOWER_ATTACK_INTERVAL_SLOW:uint   = 20;
		public static const TOWER_ATTACK_INTERVAL_MEDIUM:uint = 10;
		public static const TOWER_ATTACK_INTERVAL_FAST:uint   = 5;
			
		public static var towers:Vector.<Tower>;
		
		// enemies
		public static var enemies:Vector.<Enemy>;
		
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
			
			root.addEventListener(TouchEvent.TOUCH, gameInput);
			
			layerBG = new Sprite();
			root.addChild(layerBG);
			
			layerGame = new Sprite();
			root.addChild(layerGame);
			
			layerUI = new Sprite();
			root.addChild(layerUI);

			// set up arrays
			enemies = new Vector.<Enemy>();
			towers  = new Vector.<Tower>();
			
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
					tileImg.name = "tile_"+x+"_"+y;
					tileImg.x = x*tileWidth;
					tileImg.y = y*tileHeight;
					layerBG.addChild(tileImg);
				}
			}
			// draw grid
			
			prevTouchedTile = null;
			
			// test enemy
			new EnemyLight(100,100);
			
			
			
		}
		
		public static function gameInput(evt:TouchEvent):void
		{
			var touch:Touch;
			touch = evt.getTouch(root, TouchPhase.BEGAN);
			if (touch)
			{
				touchPos = touch.getLocation(root);
				isTouching = true;
				//trace("Touched object began at position: " + touchPos);
			}
			
			touch = evt.getTouch(root, TouchPhase.MOVED);
			if(touch)
			{
				touchPos = touch.getLocation(root);
				isTouching = true;
				//trace("Touched object move at position: " + touchPos);
			}
			
			touch = evt.getTouch(root, TouchPhase.ENDED);
			if(touch)
			{
				touchPos = touch.getLocation(root);
				isTouching = false;
				//trace("Touched object ended at position: " + touchPos);
			}
		}
		
		public static function gameUpdate(evt:Event):void
		{
			// per frame
			var currMS:Number = getTimer();
			elapsedMS = currMS - totalElapsedMS;
			totalElapsedMS = currMS;
			
			//////////////////
			// game logic
			//////////////////
			
			
			// handle input
			// convert touchPos to grid cell index
			var gx:int = Math.floor(touchPos.x / 32);
			var gy:int = Math.floor(touchPos.y / 32);
			if(isTouching)
			{
				if(gx != prevTouchedGX || gy != prevTouchedGY)
				{
					// default color tint is white
					if(prevTouchedTile)
						prevTouchedTile.color = 0xFFFFFF;
					
					var tileImg:Image = layerBG.getChildByName("tile_"+gx+"_"+gy) as Image;
					tileImg.color = TILE_TINT_COLOR;
					prevTouchedTile = tileImg;
					prevTouchedGX = gx;
					prevTouchedGY = gy;
					//tileImg.visible = true;
				}
			}
			else if(prevTouchedTile)
			{
				prevTouchedTile.color = 0xFFFFFF;
				prevTouchedTile = null;
				
				if(grid[gx][gy] == null)
				{
					grid[gx][gy] = new TowerLongbow(gx*tileWidth, gy*tileHeight);
				}
			}
			
			
			var i:int;
			
			// update enemies
			for(i = 0; i < enemies.length; i++)
			{
				enemies[i].update();
			}
			
			// clean up
			var c:int;
			for(c = 0; c < enemies.length; )
			{
				if(enemies[c].bMarkedForDestroy)
				{
					enemies[c].destroy();
					enemies.splice(c,1);
				}
				else
					c++;
			}
		}
		
		public static function gameEnd():void
		{
		}
	}
}