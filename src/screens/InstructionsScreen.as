package screens
{
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;

	public class InstructionsScreen extends Screen
	{
		private var img:Image;
		private var text:TextField;
		
		public function InstructionsScreen()
		{
			img = new Image(GM.assets.getTexture("ui_instructions"));
			img.x = (GM.root.stage.stageWidth - img.width) * 0.5;
			img.y = 50;
			this.addChild(img);
			this.addEventListener(TouchEvent.TOUCH, OnTouch);
		}
		
		public function OnTouch(evt:TouchEvent):void
		{
			var touch:Touch = evt.getTouch(this, TouchPhase.ENDED);
			if(touch)
			{
				hide();
				GM.gameStart();
			}
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