package particles
{
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	
	public class StaticParticle extends Particle
	{
		public function StaticParticle(tex:Texture)
		{
			super();
			
			var img:Image = new Image(tex);
			img.touchable = false;
			img.smoothing = TextureSmoothing.NONE;
			this.displayObject = img;
		}
		
		public override function On(parent:DisplayObjectContainer, params:Object):void
		{
			super.On(parent, params);
			
			this.displayObject.x = m_params.x;
			this.displayObject.y = m_params.y;
			this.displayObject.scaleX = this.displayObject.scaleY = Math.random() * 0.5 + 1;
			this.displayObject.alpha = 1;
		}
		
//		public override function Update(elapsedTime:Number):void
//		{
//			super.Update(elapsedTime);
//		}
	}
}