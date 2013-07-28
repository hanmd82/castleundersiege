package tower
{
	import projectile.*;
	import enemy.Enemy;

	import flash.geom.Point;
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

		public function detectEnemies():Vector.<Enemy>
		{
			var enemiesInRange:Vector.<Enemy> = new Vector.<Enemy>();

			for each (var e:Enemy in GM.enemies)
			{
				var enemyPos:Point = new Point(e.sprite.x, e.sprite.y);
				var distance:Number = Point.distance(towerPos, enemyPos);
				if (distance < attackRadius)
				{
					enemiesInRange.push(e);
				}
			}
			return enemiesInRange;
		}

		public function shoot():void
		{
			if (isReloaded)
			{
				var enemies:Vector.<Enemy> = detectEnemies();
				if (enemies.length != 0)
				{
					var current_projectile:Projectile;
					var target:Enemy = enemies[0];
					var targetPos:Point = new Point(target.sprite.x, target.sprite.y);

					var attackAngle:Number = Math.atan2(targetPos.y - towerPos.y, targetPos.x - towerPos.x);

					switch(projectileType)
					{
						case "projectile_basic":
							current_projectile = new ProjectileBasic(towerPos.x, towerPos.y, GM.PROJECTILE_SPEED_FAST, attackAngle);
							break;

						case "projectile_bomb":
							current_projectile = new ProjectileBomb(towerPos.x, towerPos.y, GM.PROJECTILE_SPEED_SLOW, attackAngle);
							break;
					}
				}
			}
		}
	}
}