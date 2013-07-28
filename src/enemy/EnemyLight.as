package enemy
{
	import starling.display.Image;
	

	public class EnemyLight extends Enemy
	{
		public function EnemyLight(params:SpawnParams)
		{
			super(params.route);
			
			var img:Image = new Image(GM.assets.getTexture("enemy_light"));
			img.x = -img.width * 0.5;
			img.y = -img.height * 0.5;
			sprite.addChild(img);
			
			speed = GM.ENEMY_SPEED_LIGHT;
			hp = GM.ENEMY_HIT_POINTS_LIGHT;
		}
	}
}