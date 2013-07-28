package tower
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	import com.greensock.easing.Quad;
	
	import starling.display.Image;
	
	public class ArmyMan extends Image
	{
		private var oy:Number;
		public function ArmyMan(x:Number, y:Number)
		{
			super(GM.assets.getTexture("armymen"));
			this.x = x;
			this.y = y;
			oy = y;
			ready();
		}
		
		public function ready():void
		{
			TweenMax.to(this, 0.6, {
				delay: Math.random() * 2,
				onComplete: jump
			});
		}
		public function jump():void
		{
			var jumpY:Number = oy - 5;
			
			TweenMax.to(this, 0.3, {
				y:jumpY,
				ease: com.greensock.easing.Quad.easeOut
			});
			TweenMax.to(this, 0.3, {
				delay: 0.3,
				y:oy,
				ease: com.greensock.easing.Quad.easeIn,
				onComplete: ready
			});
		}
	}
}