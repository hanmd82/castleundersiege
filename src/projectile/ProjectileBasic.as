package projectile
{
	import enemy.Enemy;
	
	import starling.display.Image;
	import starling.textures.TextureSmoothing;

	public class ProjectileBasic extends Projectile
	{
		public function ProjectileBasic(posX:Number, posY:Number, initialSpeed:Number, initialAngle:Number)
		{
			super();

			var img:Image = new Image(GM.assets.getTexture("projectile_basic"));
			img.touchable = false;
			img.smoothing = TextureSmoothing.NONE;
			sprite.addChild(img);
			sprite.x = posX;
			sprite.y = posY;
			speed = initialSpeed;
			angle = initialAngle;

			damage = GM.PROJECTILE_DAMAGE_LIGHT;
			damageRadius = GM.PROJECTILE_DAMAGE_RADIUS_SMALL;
		}

		public override function dealDamage(enemiesHit:Vector.<Enemy>):void
		{
			// damages a point target on hit
			var e:Enemy = enemiesHit[0];
			e.sustainDamage(damage);
		}
	}
}