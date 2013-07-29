package screens
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.TextureSmoothing;

	public class InstructionsScreen extends Screen
	{
		private var img:Image;
		private var btn:Button;
		private var text:TextField;
		
		public function InstructionsScreen()
		{
			img = new Image(GM.assets.getTexture("ui_instructions"));
			//img.touchable = false;
			img.smoothing = TextureSmoothing.NONE;
			img.x = (GM.root.stage.stageWidth - img.width) * 0.5;
			img.y = 50;
			this.addChild(img);
			
			btn = new Button(GM.assets.getTexture("ui_defend_btn_up"), "",
				GM.assets.getTexture("ui_defend_btn_down"));
			btn.x = img.x + ((img.width-4 - btn.width)>>1);
			btn.y = img.y + 180;
			this.addChild(btn);
			btn.addEventListener(Event.TRIGGERED, OnBtnTriggered);
		}
		
		public function OnBtnTriggered(evt:Event):void
		{
			hide();
			GM.gameStart();
		}
		
		public function show():void
		{
			GM.layerUI.addChild(this);
			GM.blockInput = true;
		}
		public function hide():void
		{
			GM.layerUI.removeChild(this);
			GM.blockInput = false;
		}
	}
}