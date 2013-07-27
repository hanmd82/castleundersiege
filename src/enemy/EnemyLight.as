package enemy
{
	import starling.display.Image;

	public class EnemyLight extends Enemy
	{
		public function EnemyLight(posX:Number, posY:Number)
		{
			super();
			
			var img:Image = new Image(GM.assets.getTexture("enemy_light"));
			sprite.addChild(img);
			sprite.x = posX;
			sprite.y = posY;
			
//			speed = 5;
//			angle = 60;
		}
	}
}