package
{
	import starling.display.Sprite;
	
	public class Game extends Sprite
	{
		public static var instance:Game;
		
		public function Game()
		{
			instance = this;
		}
		
		public static function startGame():void
		{
			GM.gameInit(Game.instance);
		}
	}
}