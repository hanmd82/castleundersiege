package projectile
{
	import starling.display.Image;

	public class ProjectileBomb extends Projectile
	{
		// causes splash damage on hit

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
	}
}