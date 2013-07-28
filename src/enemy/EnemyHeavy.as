package enemy
{
	import starling.display.Image;
	

	public class EnemyHeavy extends Enemy
	{
		public function EnemyHeavy(params:SpawnParams)
		{
			super(params.route);
			
			var img:Image = new Image(GM.assets.getTexture("enemy_heavy"));
			img.x = -img.width * 0.5;
			img.y = -img.height * 0.5;
			sprite.addChild(img);
			
			speed = GM.ENEMY_SPEED_HEAVY;
			hp = GM.ENEMY_HIT_POINTS_HEAVY;
		}
	}
}