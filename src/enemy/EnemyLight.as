package enemy
{
	import starling.display.Image;
	import starling.textures.TextureSmoothing;
	

	public class EnemyLight extends Enemy
	{
		public function EnemyLight(params:SpawnParams)
		{
			super(params.route);
			
			var img:Image = new Image(GM.assets.getTexture("enemy_light"));
			img.touchable = false;
			img.smoothing = TextureSmoothing.NONE;
			img.x = -img.width * 0.5;
			img.y = -img.height * 0.5;
			sprite.addChild(img);
			
			speed = GM.ENEMY_SPEED_LIGHT;
			hp = GM.ENEMY_HIT_POINTS_LIGHT;
		}
	}
}