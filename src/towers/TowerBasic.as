package towers
{
	import starling.display.Image;

	public class TowerBasic extends Tower
	{
		public function TowerLongbow(posX:Number, posY:Number)
		{
			super();
			
			var img:Image = new Image(GM.assets.getTexture("tower_basic"));
			sprite.addChild(img);
			sprite.x = posX;
			sprite.y = posY;
			
			damage         = GM.TOWER_ATTACK_DAMAGE_LIGHT;
			range          = GM.TOWER_ATTACK_RANGE_NEAR;
			attackInterval = GM.TOWER_ATTACK_INTERVAL_MEDIUM;
			numBarrels     = 1;
		}
	}
}