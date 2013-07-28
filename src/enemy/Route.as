package enemy
{
	import behaviours.AStarNode;
	
	import starling.display.Image;
	import starling.display.Sprite;

	public class Route
	{
		public var startNode:AStarNode;
		public var spawnX:Number;
		public var spawnY:Number;
		public var path:Vector.<AStarNode>;
		public var temp_path:Vector.<AStarNode>;
		
		public function Route(startGX:int, startGY:int, offsetX:Number, offsetY:Number)
		{
			path = null;
			startNode = new AStarNode(startGX, startGY);
			spawnX = (startGX + 0.5) * GM.tileWidth + offsetX;
			spawnY = (startGY + 0.5) * GM.tileHeight + offsetY;
			
			var sprite:Sprite = new Sprite();
			GM.layerGame.addChild(sprite);
			
			var img:Image= new Image(GM.assets.getTexture("projectile_bomb"));
			sprite.addChild(img);
			img.x = startGX * GM.tileWidth;
			img.y = startGY * GM.tileHeight;
		}		
	}
}