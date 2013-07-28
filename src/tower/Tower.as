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
		
		public function destroy():void
		{
			sprite.removeFromParent(true);
			sprite = null;
		}

		public function scanforEnemies():Vector.<Enemy>
		{
			var enemiesInRange:Vector.<Enemy> = new Vector.<Enemy>();

			if (isReloaded)
			{
				// reuse point
				var enemyPos:Point = new Point();
				for each (var e:Enemy in GM.enemies)
				{
					enemyPos.x = e.sprite.x;
					enemyPos.y = e.sprite.y;
					var distance:Number = Point.distance(towerPos, enemyPos);
					if (distance < attackRadius)
					{
						enemiesInRange.push(e);
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
					var towerCenterPos:Point = new Point(sprite.x, sprite.y);

					// aim for the nearest target
					var target:Enemy = enemies[0];
					var targetCenterPos:Point = new Point(target.sprite.x, target.sprite.y);
					var currentTargetDistance:int = Point.distance(towerCenterPos, targetCenterPos);

					// reuse point;
					var enemyPos:Point = new Point();
					for each (var e:Enemy in enemies)
					{
						enemyPos.x = e.sprite.x;
						enemyPos.y = e.sprite.y;
						var currentEnemyDistance:int = Point.distance(towerCenterPos, enemyPos);
						if (currentEnemyDistance < currentTargetDistance)
						{
							target = e;
							targetCenterPos = enemyPos;
							currentTargetDistance = currentEnemyDistance;
						}
					}
					var y_coordinateDifference:int = targetCenterPos.y - towerCenterPos.y;
					var x_coordinateDifference:int = targetCenterPos.x - towerCenterPos.x;
					var attackAngle:Number = Math.atan2(y_coordinateDifference, x_coordinateDifference) * 180/Math.PI;
					// trace("%d", attackAngle);

					switch(projectileType)
					{
						case "projectile_basic":
							current_projectile = new ProjectileBasic(towerPos.x, towerPos.y - sprite.height*0.5, GM.PROJECTILE_SPEED_FAST, attackAngle);
							break;

						case "projectile_bomb":
							current_projectile = new ProjectileBomb(towerPos.x, towerPos.y - sprite.height*0.5, GM.PROJECTILE_SPEED_SLOW, attackAngle);
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