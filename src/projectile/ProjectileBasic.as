package projectile
{
	import starling.display.Image;

	public class ProjectileBasic extends Projectile
	{
		public function ProjectileBasic(posX:Number, posY:Number, speed:Number, angle:Number)
		{
			super();
			
			var img:Image = new Image(GM.assets.getTexture("projectile_basic"));
			sprite.addChild(img);
			sprite.x = posX;
			sprite.y = posY;
			
			set speed(speed);
			set angle(angle);
			
			damage = GM.PROJECTILE_DAMAGE_LIGHT;
			damageRadius = GM.PROJECTILE_HIT_RADIUS_SMALL;
		}
	}
}