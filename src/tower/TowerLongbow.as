package tower
{
	import starling.display.Image;

	public class TowerLongbow extends Tower
	{
		public function TowerLongbow(posX:Number, posY:Number)
		{
			super();
			
			var img:Image = new Image(GM.assets.getTexture("tower_longbow"));
			sprite.addChild(img);
			sprite.x = posX;
			sprite.y = posY;
			
			attackRadius   = GM.TOWER_ATTACK_RADIUS_LARGE;
			attackInterval = GM.TOWER_ATTACK_INTERVAL_MEDIUM;
			numProjectiles = 1;
		}
	}
}