package projectile
{
	import enemy.Enemy;

	import flash.geom.Point;

	import starling.display.Image;

	public class ProjectileBomb extends Projectile
	{
		public function ProjectileBomb(posX:Number, posY:Number, initialSpeed:Number, initialAngle:Number)
		{
			super();

			var img:Image = new Image(GM.assets.getTexture("projectile_bomb"));
			sprite.addChild(img);
			sprite.x = posX;
			sprite.y = posY;

			this.speed = initialSpeed;
			this.angle = initialAngle;

			damage = GM.PROJECTILE_DAMAGE_HEAVY;
			damageRadius = GM.PROJECTILE_HIT_RADIUS_MEDIUM;
		}

		public override function dealDamage(enemiesHit:Vector.<Enemy>):void
		{
			// causes splash damage on all enemies within range
			var projectilePos:Point = new Point(sprite.x, sprite.y);
			for each (var e:Enemy in GM.enemies)
			{
				var enemyPos:Point = new Point(e.sprite.x, e.sprite.y);
				var distance:Number = Point.distance(projectilePos, enemyPos);
				if (distance < damageRadius)
				{
					e.sustainDamage(damage);
				}
			}
		}
	}
}