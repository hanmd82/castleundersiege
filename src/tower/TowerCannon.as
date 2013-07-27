package tower
{
	import starling.display.Image;

	public class TowerCannon extends Tower
	{
		public function TowerCannon(posX:Number, posY:Number)
		{
			super();
			
			var img:Image = new Image(GM.assets.getTexture("tower_cannon"));
			sprite.addChild(img);
			sprite.x = posX;
			sprite.y = posY;
			
			attackRadius   = GM.TOWER_ATTACK_RADIUS_SMALL;
			attackInterval = GM.TOWER_ATTACK_INTERVAL_SLOW;
			numProjectiles = 1;
		}
	}
}