package tower
{
	import flash.geom.Point;
	import starling.display.Sprite;

	public class Tower
	{
		public var attackRadius:Number;
		public var attackInterval:Number;	// ammo reload interval
		public var numProjectiles:Number;	// that can be fired in parallel
		
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