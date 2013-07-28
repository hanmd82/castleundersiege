package tower
{
	import starling.display.Image;

	public class TowerBasic extends Tower
	{
		public var img:Image;

		public function TowerBasic(posX:Number, posY:Number)
		{
			super();

			towerAttributeSet = "tower_basic";

			img = new Image(GM.assets.getTexture("tower_basic"));
			sprite.addChild(img);
			sprite.x = posX;
			sprite.y = posY;

			attackRadius   = GM.TOWER_ATTACK_RADIUS_SMALL;
			attackInterval = GM.TOWER_ATTACK_INTERVAL_MEDIUM;
			numProjectiles = 1;
		}

		public function upgrade(newTowerAttributeSet:String):void
		{
			if (towerAttributeSet == "tower_basic")
			{
				// TowerBasic can upgrade to TowerCannon or TowerLongbow
				switch (newTowerAttributeSet){

					case "tower_longbow":
						trace("upgraded to long-range longbow tower");
						towerAttributeSet = "tower_longbow";
						img.texture       = GM.assets.getTexture("tower_longbow");
						attackRadius      = GM.TOWER_ATTACK_RADIUS_LARGE;
						attackInterval    = GM.TOWER_ATTACK_INTERVAL_MEDIUM;
						break;

					case "tower_cannon":
						trace("upgraded to high-damage cannon tower");
						towerAttributeSet = "tower_cannon";
						img.texture       = GM.assets.getTexture("tower_cannon");
						attackRadius      = GM.TOWER_ATTACK_RADIUS_SMALL;
						attackInterval    = GM.TOWER_ATTACK_INTERVAL_SLOW;
						break;
				}
			}
		}
	}
}