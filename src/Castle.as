package
{
	import behaviours.AStarNode;
	
	import enemy.Enemy;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.TextureSmoothing;

	public class Castle
	{
		public var hp:int;
		public var node:AStarNode;
		
		public function Castle(gx:int, gy:int)
		{
			hp = GM.CASTLE_HP_MAX;
			
			var sprite:Sprite = new Sprite();
			GM.layerGame.addChild(sprite);
			
			var img:Image= new Image(GM.assets.getTexture("castle"));
			img.touchable = false;
			img.smoothing = TextureSmoothing.NONE;
			sprite.addChild(img);
			img.x = gx * GM.tileWidth - 52;
			img.y = gy * GM.tileHeight - 74;
			
			node = new AStarNode(gx,gy);
		}
		
		public function containsPos(x:Number, y:Number):Boolean
		{
			return contains(x/GM.tileWidth, y/GM.tileHeight); 
		}
		public function contains(gx:int, gy:int):Boolean
		{
			return (gx >= node.x-1 && gx <= node.x+2 &&
				gy >= node.y-2 && gy <= node.y+1);
		}
		
		public function enteredByEnemy(e:Enemy):void
		{
			hp--;
		}
	}
}