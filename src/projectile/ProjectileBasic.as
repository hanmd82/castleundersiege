package projectile
{
	import starling.display.Image;

	public class ProjectileBasic extends Projectile
	{
		// damages a point target on hit

		public function ProjectileBasic(posX:Number, posY:Number, initialSpeed:Number, initialAngle:Number)
		{
			super();

			var img:Image = new Image(GM.assets.getTexture("projectile_basic"));
			sprite.addChild(img);
			sprite.x = posX;
			sprite.y = posY;

			this.speed = initialSpeed;
			this.angle = initialAngle;

			damage = GM.PROJECTILE_DAMAGE_LIGHT;
			damageRadius = GM.PROJECTILE_HIT_RADIUS_SMALL;
		}
	}
}