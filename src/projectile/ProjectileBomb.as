package projectile
{
	import starling.display.Image;

	public class ProjectileBomb extends Projectile
	{
		public function ProjectileBomb(posX:Number, posY:Number, speed:Number, angle:Number)
		{
			super();
				
			var img:Image = new Image(GM.assets.getTexture("projectile_bomb"));
			sprite.addChild(img);
			sprite.x = posX;
			sprite.y = posY;
				
			set speed(speed);
			set angle(angle);
			
			damage = GM.PROJECTILE_DAMAGE_HEAVY;
			damageRadius = GM.PROJECTILE_HIT_RADIUS_MEDIUM;
		}
	}
}