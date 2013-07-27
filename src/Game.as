package
{
	import starling.display.Sprite;
	import starling.text.TextField;

	public class Game extends Sprite
	{
		public function Game()
		{
			// test drawing
			
			var tf:TextField = new TextField(500, 300, "hello world");
			this.addChild(tf);
		}
	}
}