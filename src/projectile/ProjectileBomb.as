package projectile
{
	import flash.geom.Point;
	
	import enemy.Enemy;
	
	import starling.display.Image;
	import starling.textures.TextureSmoothing;

	public class ProjectileBomb extends Projectile
	{
		private static var enemyPos:Point;

		public function ProjectileBomb(posX:Number, posY:Number, initialSpeed:Number, initialAngle:Number)
		{
			super();

			var img:Image = new Image(GM.assets.getTexture("projectile_bomb"));
			img.touchable = false;
			img.smoothing = TextureSmoothing.NONE;
			sprite.addChild(img);
			sprite.x = posX;
			sprite.y = posY;
			speed = initialSpeed;
			angle = initialAngle;

			damage = GM.PROJECTILE_DAMAGE_HEAVY;
			damageRadius = GM.PROJECTILE_DAMAGE_RADIUS_MEDIUM;
		}

		public override function dealDamage(enemiesHit:Vector.<Enemy>):void
		{
			// causes splash damage on all enemies within range
			var projectilePos:Point = new Point(sprite.x, sprite.y);
			enemyPos = new Point();
			var distance:Number;
			for each (var e:Enemy in GM.enemies)
			{
				enemyPos.x = e.sprite.x;
				enemyPos.y = e.sprite.y;
				distance   = Point.distance(projectilePos, enemyPos);
				if (distance < damageRadius)
				{
					e.sustainDamage(damage);
				}
			}
		}
	}
}