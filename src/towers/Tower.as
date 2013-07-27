package towers
{
	import flash.geom.Point;
	import starling.display.Sprite;

	public class Tower
	{
		public var damage:Number;
		public var range:Number;
		public var attackInterval:Number;
		public var numBarrels:Number;
		
		public var towerPos:Point;
		public var sprite:Sprite;
		
		public function Tower()
		{
			sprite = new Sprite();
			GM.towers.push(this);
			GM.layerGame.addChild(sprite);
		}
	}
}