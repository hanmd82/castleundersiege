package
{
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.system.Capabilities;
	import flash.utils.getTimer;
	
	import behaviours.AStar;
	
	import enemy.Enemy;
	import enemy.EnemyHeavy;
	import enemy.EnemyLight;
	import enemy.Route;
	import enemy.SpawnParams;
	import enemy.Wave;
	
	import particles.BurstParticle;
	import particles.Particle;
	import particles.ParticlesPool;
	import particles.SnowParticle;
	import particles.StaticParticle;
	
	import projectile.Projectile;
	
	import screens.InstructionsScreen;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	import tower.Tower;
	import tower.TowerBasic;


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
		public static const canvasWidth:int = tileWidth * gridNumCellsX;
		public static const canvasHeight:int = tileHeight * gridNumCellsY;
		public static var grid:Array;

		public static var root:DisplayObjectContainer;
		public static var layerBG:Sprite;
		public static var layerGame:Sprite;
		public static var layerParticles:Sprite;
		public static var layerUI:Sprite;

		public static var totalElapsedMS:int;
		public static var elapsedMS:int;
		
		public static var isPaused:Boolean = false;
		public static var blockInput:Boolean = false;

		// assets manager
		public static var assets:AssetManager;
		
		// touch input (only one button for now)
		public static var touchPos:Point = new Point();
		public static var isTouching:Boolean = false;
		public static var isPress:Boolean = false;
		public static var isRelease:Boolean = false;
		
		// TILE
		public static var tileSelectedImg:Image;
		public static var prevTouchedGX:int;
		public static var prevTouchedGY:int;
		public static const TILE_TINT_VALID_COLOR:uint = 0x339933;
		public static const TILE_TINT_INVALID_COLOR:uint = 0x993300;
		
		// towers		
		// TOWER ATTACK DATA
		public static const TOWER_DETECTION_RADIUS_SMALL:uint  = 100;
		public static const TOWER_DETECTION_RADIUS_MEDIUM:uint = 200;
		public static const TOWER_DETECTION_RADIUS_LARGE:uint  = 300;

		public static const TOWER_RELOAD_INTERVAL_MS_SLOW:uint   = 2000;
		public static const TOWER_RELOAD_INTERVAL_MS_MEDIUM:uint = 1000;
		public static const TOWER_RELOAD_INTERVAL_MS_FAST:uint   = 500;

		public static var towers:Vector.<Tower>;

		// projectiles
		public static const PROJECTILE_SPEED_SLOW:uint    = 1;
		public static const PROJECTILE_SPEED_MEDIUM:uint  = 3;
		public static const PROJECTILE_SPEED_FAST:uint    = 5;

		public static const PROJECTILE_DAMAGE_LIGHT:uint  = 20;
		public static const PROJECTILE_DAMAGE_MEDIUM:uint = 30;
		public static const PROJECTILE_DAMAGE_HEAVY:uint  = 50;

		public static const PROJECTILE_DAMAGE_RADIUS_SMALL:uint  = 10;
		public static const PROJECTILE_DAMAGE_RADIUS_MEDIUM:uint = 30;
		public static const PROJECTILE_DAMAGE_RADIUS_LARGE:uint  = 50;

		public static var projectiles:Vector.<Projectile>;

		// enemies
		public static const ENEMY_HIT_POINTS_LIGHT:uint = 15;
		public static const ENEMY_HIT_POINTS_HEAVY:uint = 75;
		public static const ENEMY_HIT_POINTS_KAMI:uint  = 40;
		public static const ENEMY_SPEED_LIGHT:Number  = 0.5;
		public static const ENEMY_SPEED_HEAVY:Number = 0.16;
		public static const ENEMY_SPEED_KAMI:Number  = 0.1;
		public static var enemies:Vector.<Enemy>;
		public static var routes:Vector.<Route>;
		public static var astar:AStar;
		
		// castle home
		public static const CASTLE_HP_MAX:int = 20;
		public static var castle:Castle;
		
		// waves
		public static var wavesQueue:Vector.<Wave>;
		
		// particles
		public static var particlesSnow:ParticlesPool;
		public static var particlesExplode:ParticlesPool;
		public static var particlesExplodeCirc:ParticlesPool;
		
		// ui
		public static var instructions:InstructionsScreen;
		public static var castleHPText:TextField;
		
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
			isPaused = true;
			
			layerBG = new Sprite();
			root.addChild(layerBG);
			
			layerGame = new Sprite();
			root.addChild(layerGame);
			
			layerParticles = new Sprite();
			root.addChild(layerParticles);
			
			layerUI = new Sprite();
			root.addChild(layerUI);

			// set up arrays
			towers      = new Vector.<Tower>();
			projectiles = new Vector.<Projectile>();
			enemies     = new Vector.<Enemy>();
			routes		= new Vector.<Route>();
			wavesQueue	= new Vector.<Wave>();
			
			astar = new AStar(); 
			
//			var tf:TextField = new TextField(500, 300, "hello world");
//			root.addChild(tf);
			
			// bg
			layerBG.addChild(new Image(assets.getTexture("bg")));
			
			// tile texture
			var tileTex:Texture = assets.getTexture("tile");
			tileSelectedImg = new Image(tileTex);
			tileSelectedImg.touchable = false;
			tileSelectedImg.smoothing = TextureSmoothing.NONE;
			tileSelectedImg.visible = false;
			layerBG.addChild(tileSelectedImg);
			
			// set up grid
			grid = new Array(gridNumCellsX);
			for(var x:int = 0; x < gridNumCellsX; x++)
			{
				grid[x] = new Array(gridNumCellsY);
//				for(var y:int = 0; y < gridNumCellsY; y++)
//				{
					//grid[x][y]
//					var tileImg:Image = new Image(tileTex);
//					tileImg.name = "tile_"+x+"_"+y;
//					tileImg.x = x*tileWidth;
//					tileImg.y = y*tileHeight;
//					layerBG.addChild(tileImg);
//				}
			}
			// draw grid
			
			
			// init castle
			castle = new Castle(gridNumCellsX/2 -1, gridNumCellsY-2); // 9, 13
			
			setupParticles();
			
			
			// setup ui
			var castleHPIcon:Image = new Image(assets.getTexture("ui_castle_hp"));
			castleHPIcon.touchable = false;
			castleHPIcon.smoothing = TextureSmoothing.NONE;
			castleHPIcon.x = 10;
			castleHPIcon.y = 5;
			layerUI.addChild(castleHPIcon);
			castleHPText = new TextField(100, 30, "x "+castle.hp, "04b03", 24, 0x15191a);
			castleHPText.x = 41;
			castleHPText.y = 14;
			castleHPText.hAlign = HAlign.LEFT;
			castleHPText.vAlign = VAlign.TOP;
			layerUI.addChild(castleHPText);
			
			instructions = new InstructionsScreen();
			instructions.show();
			
			
			// play music
			var bgm:Sound = new CastleUnderSiegeBGM();
			bgm.play(0,int.MAX_VALUE, new SoundTransform(0.7));
		}
		
		public static function gameStart():void
		{
			isPaused = false;
			totalElapsedMS = getTimer();
			root.addEventListener(TouchEvent.TOUCH, gameInput);
			
			isTouching = false;
			isPress = false;
			isRelease = false;
			
			// reset hp
			castle.hp = CASTLE_HP_MAX;
			
			// set up starting positions for route
			// must be done before waves
			setupRoutes();
			
			// set up waves
			setupWaves();
			
		}
		
		public static function gameInput(evt:TouchEvent):void
		{
			if(blockInput)
				return;
			
			isPress = false;
			isRelease = false;
			
			var touch:Touch;
			touch = evt.getTouch(root, TouchPhase.BEGAN);
			if (touch)
			{
				touchPos = touch.getLocation(root);
				isTouching = true;
				isPress = true;
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
				if(isTouching)
				{
					isTouching = false;
					isRelease = true;
				}
				//trace("Touched object ended at position: " + touchPos);
			}
		}
		
		public static function gameUpdate(evt:Event):void
		{
			// per frame
			var currMS:int = getTimer();
			elapsedMS = currMS - totalElapsedMS;
			totalElapsedMS = currMS;
			var elapsedSeconds:Number = elapsedMS/1000;
			
			// particles
			particlesSnow.Update(elapsedSeconds);
			particlesExplode.Update(elapsedSeconds);
			particlesExplodeCirc.Update(elapsedSeconds);
			
			
			//////////////////
			// game logic
			//////////////////
			
			// return if Paused
			if(isPaused)
				return;
			
			// handle input
			
			// convert touchPos to grid cell index
			var gx:int = Math.floor(touchPos.x / 32);
			var gy:int = Math.floor(touchPos.y / 32);
			if(isTouching)
			{
				if(gx != prevTouchedGX || gy != prevTouchedGY)
				{
					prevTouchedGX = gx;
					prevTouchedGY = gy;
					
					tileSelectedImg.x = gx * tileWidth;
					tileSelectedImg.y = gy * tileHeight;
					tileSelectedImg.visible = true;
					
					if(grid[gx][gy] != null)
					{
						tileSelectedImg.visible = false;
						
					}
					else if(checkTowerCellValid(gx, gy))
					{
						tileSelectedImg.color = TILE_TINT_VALID_COLOR;
						//tileImg.visible = true;
					}
					else
					{
						tileSelectedImg.color = TILE_TINT_INVALID_COLOR;
					}
				}
			}
			else if(isRelease) // released touch
			{
				//tileSelectedImg.color = 0xFFFFFF;
				tileSelectedImg.visible = false;
				
				if(checkTowerCellValid(gx, gy))
				{
					grid[gx][gy] = new TowerBasic(gx, gy);
					// whenever tower is placed, we have to re-route
					for(var r:int = routes.length-1; r >= 0; r--)
					{
						routes[r].path = routes[r].temp_path;
					}
				}
				else
				{
					// show tower upgrade UI
				}
			}


			var i:int;
			
			// update front wave
			if(wavesQueue.length > 0)
			{
				wavesQueue[0].update();
				if(wavesQueue[0].isEnded)
				{
					wavesQueue.shift();
				}
			}
			
			// update enemies
			for(i = 0; i < enemies.length; i++)
			{
				enemies[i].update();
			}

			for(i = 0; i < projectiles.length; i++)
			{
				projectiles[i].update();
			}

			for(i = 0; i < towers.length; i++)
			{
				towers[i].update(); // health, damage and reloading status
				var enemiesInRange:Vector.<Enemy> = towers[i].scanforEnemies();
				towers[i].shoot(enemiesInRange);
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
			
			for(c = 0; c < projectiles.length; )
			{
				if(projectiles[c].bMarkedForDestroy)
				{
					projectiles[c].destroy();
					projectiles.splice(c,1);
				}
				else
					c++;
			}
			
			// update ui
			castleHPText.text = "x "+castle.hp.toString();
			
			// check game over
			if(castle.hp <= 0)
				GM.gameEnd();
		}
		
		private static function checkTowerCellValid(gx:int, gy:int):Boolean
		{
			// first check if something already there
			if(grid[gx][gy] != null)
			{
				return false;
			}
			// check if it is within castle
			else if(castle.contains(gx,gy))
			{
				return false;
			}
			else
			{
				// check routes are valid
				// set something to grid temporarily to block it
				grid[gx][gy] = 123;
				for(var r:int = routes.length-1; r >= 0; r--)
				{
					routes[r].temp_path = astar.search(routes[r].startNode, castle.node);
					if(routes[r].temp_path == null)
					{
						return false;
					}
				}
				// unset grid cell
				grid[gx][gy] = null;
			}
			
			return true;
		}
		
		public static function gameEnd():void
		{
			// stop update
			isPaused = true;
			root.removeEventListener(TouchEvent.TOUCH, gameInput);
			
			// clear off all entities
			var i:int;
			for(i = enemies.length-1; i >=0; i--)
			{
				enemies.pop().destroy();
			}
			for(i = towers.length-1; i>=0; i--)
			{
				towers.pop().destroy();
			}
			for(i = projectiles.length-1; i>=0; i--)
			{
				projectiles.pop().destroy();
			}
			for(i = routes.length-1; i>=0; i--)
			{
				routes.pop().destroy();
			}
			for(i = wavesQueue.length-1; i>=0; i--)
			{
				wavesQueue.pop().destroy();
			}
			
			// show the instructions again
			instructions.show();
		}
		
		public static function setupParticles():void
		{
			var tex:Texture;
			var p:Particle;
			var vec:Vector.<Particle>;
			var img:Image;
			var i:int;
			
			// snow
			var snowTextures:Array = ["particle_snow_5", "particle_snow_2", "particle_snow_4", "particle_snow_6"];
			vec = new Vector.<Particle>();
			for(var t:int = 0; t < snowTextures.length; t++)
			{
				tex = assets.getTexture(snowTextures[t]);
				for(i = 0; i < 50; i++)
				{
					p = new SnowParticle(tex);
					vec.push(p);
				}
			}
			particlesSnow = new ParticlesPool(vec, layerParticles);
			particlesSnow.SetAsEmitter( 12, {
				w:root.stage.stageWidth, y:-10, 
				life:8});
			
			// burst / explode
			vec = new Vector.<Particle>();
			tex = assets.getTexture("particle_spark");
			for(i = 0; i < 24; i++)
			{
				p = new BurstParticle(i,24);
				img = new Image(tex);
				img.touchable = false;
				img.smoothing = TextureSmoothing.NONE;
				p.displayObject = img;
				vec.push(p);
			}
			particlesExplode = new ParticlesPool(vec, layerParticles);
			
			vec = new Vector.<Particle>();
			tex = assets.getTexture("particle_explode_circ");
			p = new StaticParticle(tex);
			vec.push(p);
			particlesExplodeCirc = new ParticlesPool(vec, layerParticles);
			
		}
		
		private static function setupRoutes():void
		{
			// right-mid
			routes.push(new Route(gridNumCellsX-1, (gridNumCellsY>>1), tileWidth, 0) );
			// left-mid
			routes.push(new Route(0, (gridNumCellsY>>1), -tileWidth, 0) );
			// mid-top
			routes.push(new Route( (gridNumCellsX>>1), 0, 0, -tileHeight) );
			
			// initialize paths
			for(var r:int = routes.length-1; r >= 0; r--)
			{
				routes[r].path = astar.search(routes[r].startNode, castle.node);
				
				//				var s:String = "route["+r+"] = ";
				//				for(var p:int = 0; p < routes[r].path.length; p++)
				//					s += " ["+routes[r].path[p].x + ","+routes[r].path[p].y+"]";
				//				trace(s);
			}
		}
		
		public static function setupWaves():void
		{
			var w:Wave;
			var i:int;
			
			// wave 1
			w = new Wave();
			for(i=0; i < 20; i++)
			{
				w.add(new SpawnParams(EnemyLight, i * 45, GM.routes[0]));
				w.add(new SpawnParams(EnemyHeavy, i * 45 * 3, GM.routes[1]));
				w.add(new SpawnParams(EnemyLight, i * 45, GM.routes[2]));
			}
			w.endDelayFrames = 60*20; // 10s
			wavesQueue.push(w);
			
			// wave 2
			w = new Wave();
			for(i=0; i < 20; i++)
			{
				w.add(new SpawnParams(EnemyLight, i * 45, GM.routes[1]));
				w.add(new SpawnParams(EnemyLight, i * 45, GM.routes[2]));
			}
			w.endDelayFrames = 60*20; // 10s
			wavesQueue.push(w);
		}
	}
}