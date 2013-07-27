package towers
{
	import starling.display.Image;

	public class TowerCannon extends Tower
	{
		public function TowerLongbow(posX:Number, posY:Number)
		{
			super();
			
			var img:Image = new Image(GM.assets.getTexture("tower_cannon"));
			sprite.addChild(img);
			sprite.x = posX;
			sprite.y = posY;
			
			damage         = GM.TOWER_ATTACK_DAMAGE_HEAVY;
			range          = GM.TOWER_ATTACK_RANGE_NEAR;
			attackInterval = GM.TOWER_ATTACK_INTERVAL_SLOW;
			numBarrels     = 1;
		}
	}
}