package particles
{
	import starling.display.DisplayObjectContainer;
	
	public class BurstParticle extends Particle
	{
		public static const INIT_SPEED:Number = 350;
		public static const FRICTION:Number = 0.8;
		
		private var m_index:int;
		private var m_div:int;
		private var m_directionX:Number;
		private var m_directionY:Number;
		private var m_speed:Number;
		private var m_offsetX:Number;
		private var m_offsetY:Number;
		
		public function BurstParticle(index:int, div:int)
		{
			super();
			
			m_index = index;
			m_div = div;
		}
		
		public override function On(parent:DisplayObjectContainer, params:Object):void
		{
			super.On(parent, params);
			
			var segment:Number = Math.PI * 2 / m_div;
			var angle:Number = m_index * segment; //(m_index + 0.4 + Math.random()*0.2) * segment;
			m_directionX = Math.cos(angle);
			m_directionY = Math.sin(angle);
			m_offsetX = Math.random() * 20 - 10 + m_directionX * 10;
			m_offsetY = Math.random() * 20 - 10 + m_directionY * 10;
			this.displayObject.x = Math.floor(params.x + m_offsetX);
			this.displayObject.y = Math.floor(params.y + m_offsetY);
			this.displayObject.rotation = angle;
			this.displayObject.scaleX = this.displayObject.scaleY = 2;
			this.displayObject.alpha = 1;
			
//			trace(m_index, m_div, angle, segment, m_directionX, m_directionY, this.displayObject.rotation);
			
			m_speed = INIT_SPEED;
		}
		
		public override function Update(elapsedTime:Number):void
		{
			super.Update(elapsedTime);
			
			m_offsetX += m_speed * m_directionX * elapsedTime;
			m_offsetY += m_speed * m_directionY * elapsedTime;
			this.displayObject.x =  Math.floor(m_params.x + m_offsetX);
			this.displayObject.y =  Math.floor(m_params.y + m_offsetY);
			
//			if(this.displayObject.scaleY < 1)
//			{
//				this.displayObject.scaleY += elapsedTime;
//				if(this.displayObject.scaleY > 1)
//					this.displayObject.scaleY = 1;
//				this.displayObject.scaleX = this.displayObject.scaleY;
//			}
			
			if(this.lifeRemaining < 0.2)
			{
				this.displayObject.alpha = this.lifeRemaining / 0.2;
			}
			
			m_speed *= FRICTION;
		}
	}
}