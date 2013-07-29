package particles
{
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	
	public class SnowParticle extends Particle
	{
		public static const BASE_SPEED:Number = 0.5;
		public static const SPREAD_SPEED:Number = 5;
		public static const BASE_ANGLE:Number = 80*Math.PI/180;
		public static const SPREAD_ANGLE:Number = 5 * Math.PI/180; 
		
		private var m_vX:Number;
		private var m_vY:Number;
		
		public function SnowParticle(tex:Texture)
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
			
			var angle:Number = BASE_ANGLE + (Math.random() - 0.5) * SPREAD_ANGLE;
			var speed:Number = BASE_SPEED + (Math.random() - 0.5) * SPREAD_SPEED;
			m_vX = Math.cos(angle) * speed;
			m_vY = Math.sin(angle) * speed;
			this.displayObject.x = Math.random() * m_params.w;
			this.displayObject.y = m_params.y;
			this.displayObject.scaleX = this.displayObject.scaleY = Math.random() * 1.5 + 0.5;
			this.displayObject.alpha = 1;
			
//			trace(m_index, m_div, angle, segment, m_directionX, m_directionY, this.displayObject.rotation);
		}
		
		public override function Update(elapsedTime:Number):void
		{
			super.Update(elapsedTime);
			
			this.displayObject.x += m_vX;
			this.displayObject.y += m_vY;
			
			if(this.m_lifeRemaining < 0.3)
			{
				this.displayObject.alpha = this.m_lifeRemaining / 0.3;
			}
		}
	}
}