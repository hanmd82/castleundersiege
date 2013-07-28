package tower
{
	import enemy.Enemy;
	
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	import projectile.*;
	
	import starling.display.Sprite;

	public class Tower
	{
		public var towerAttributeSet:String;

		public var attackRadius:Number;
		public var attackInterval:Number;	// ammo reload interval
		public var numProjectiles:Number;	// that can be fired in parallel
		public var projectileType:String;

		public var towerPos:Point;
		public var sprite:Sprite;
		
		public var isReloaded:Boolean;
		public var lastReloadTime:Number;

		public function Tower()
		{
			sprite = new Sprite();
			GM.towers.push(this);
			GM.layerGame.addChild(sprite);
		}

		public function scanforEnemies():Vector.<Enemy>
		{
			var enemiesInRange:Vector.<Enemy> = new Vector.<Enemy>();

			if (isReloaded)
			{
				for each (var e:Enemy in GM.enemies)
				{
					var enemyPos:Point = new Point(e.sprite.x, e.sprite.y);
					var distance:Number = Point.distance(towerPos, enemyPos);
					if (distance < attackRadius)
					{
						enemiesInRange.push(e);
						trace("detecting");
					}
				}
			}
			return enemiesInRange;
		}

		public function shoot(enemies:Vector.<Enemy>):void
		{
			if (isReloaded)
			{
				if (enemies.length != 0)
				{
					var current_projectile:Projectile;
					var target:Enemy = enemies[0];
					var targetCenterPos:Point = new Point(target.sprite.x + target.sprite.width/2, target.sprite.y + target.sprite.height/2);

					var towerCenterPos:Point = new Point(sprite.x + sprite.width/2, sprite.y + sprite.y/2);
					var attackAngle:Number = Math.atan2(targetCenterPos.y - towerCenterPos.y, targetCenterPos.x - towerCenterPos.x);

					switch(projectileType)
					{
						case "projectile_basic":
							current_projectile = new ProjectileBasic(towerPos.x + sprite.width*0.5, towerPos.y, GM.PROJECTILE_SPEED_FAST, attackAngle);
							break;

						case "projectile_bomb":
							current_projectile = new ProjectileBomb(towerPos.x + sprite.width*0.5, towerPos.y, GM.PROJECTILE_SPEED_SLOW, attackAngle);
							break;
					}
					lastReloadTime = getTimer();
					isReloaded = false;
				}
			}
		}

		public function update():void
		{
			var currMS:Number = getTimer();
			var elapsedLoadingTime:Number = currMS - lastReloadTime;
			if ( isReloaded == false && elapsedLoadingTime > attackInterval )
			{
				isReloaded = true;
			}
		}
	}
}