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
			projectileType    = "projectile_basic";

			img = new Image(GM.assets.getTexture("tower_basic"));
			towerPos.x = posX;
			towerPos.y = posY;

			sprite.addChild(img);
			sprite.x = posX;
			sprite.y = posY;

			attackRadius   = GM.TOWER_DETECTION_RADIUS_SMALL;
			attackInterval = GM.TOWER_RELOAD_INTERVAL_MS_MEDIUM;
			numProjectiles = 1;

			isReloaded = false;
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
						projectileType    = "projectile_basic";
						img.texture       = GM.assets.getTexture("tower_longbow");
						attackRadius      = GM.TOWER_DETECTION_RADIUS_LARGE;
						attackInterval    = GM.TOWER_RELOAD_INTERVAL_MS_MEDIUM;
						break;

					case "tower_cannon":
						trace("upgraded to high-damage cannon tower");
						towerAttributeSet = "tower_cannon";
						projectileType    = "projectile_bomb";
						img.texture       = GM.assets.getTexture("tower_cannon");
						attackRadius      = GM.TOWER_DETECTION_RADIUS_SMALL;
						attackInterval    = GM.TOWER_RELOAD_INTERVAL_MS_SLOW;
						break;
				}
			}
		}
	}
}