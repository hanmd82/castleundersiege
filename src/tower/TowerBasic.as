package tower
{
	import starling.display.Image;

	public class TowerBasic extends Tower
	{
		public function TowerBasic(posX:Number, posY:Number)
		{
			super();
			
			var img:Image = new Image(GM.assets.getTexture("tower_basic"));
			sprite.addChild(img);
			sprite.x = posX;
			sprite.y = posY;
			
			attackRadius   = GM.TOWER_ATTACK_RADIUS_SMALL;
			attackInterval = GM.TOWER_ATTACK_INTERVAL_MEDIUM;
			numProjectiles = 1;
		}
	}
}