package enemy
{
	import flash.geom.Point;
	
	import starling.display.Sprite;

	public class Enemy
	{
		public var hp:Number;
		public var dmg:Number;
		public var targetPos:Point;
		public var sprite:Sprite;
		public var bMarkedForDestroy:Boolean;
		
		private var m_speed:Number;
		private var m_angle:Number;
		private var m_velocityX:Number;
		private var m_velocityY:Number;
		
		public function Enemy()
		{
			bMarkedForDestroy = false;
			sprite = new Sprite();
			GM.enemies.push(this);
			GM.layerGame.addChild(sprite);
			
			m_speed = 0;
			m_angle = 0;
			m_velocityX = 0;
			m_velocityY = 0;
		}
		
		public function destroy():void
		{
			bMarkedForDestroy = true;
			GM.layerGame.removeChild(sprite);
		}
		
		public function update():void
		{
			sprite.x += m_velocityX;
			sprite.y += m_velocityY;
		}
		
		public function get speed():Number { return m_speed; }
		public function get angle():Number { return m_angle; }
		public function get vx():Number { return m_velocityX; }
		public function get vy():Number { return m_velocityY; }
		
		public function set speed(value:Number):void { m_speed = value; refreshVelocityFromSpeedAngle(); }
		public function set angle(value:Number):void { m_angle = value; refreshVelocityFromSpeedAngle(); }
		public function set vx(value:Number):void { m_velocityX = value; refreshSpeedAngleFromVelocity(); }
		public function set vy(value:Number):void { m_velocityY = value; refreshSpeedAngleFromVelocity(); }
		
		private function refreshSpeedAngleFromVelocity():void
		{
			m_speed = Math.sqrt(m_velocityX*m_velocityX + m_velocityY*m_velocityY);
			m_angle = Math.atan2(m_velocityY, m_velocityX) * (180/Math.PI);
		}
		
		private function refreshVelocityFromSpeedAngle():void
		{
			m_velocityX = m_speed * Math.cos((Math.PI/180) * m_angle);
			m_velocityY = m_speed * Math.sin((Math.PI/180) * m_angle);
		}
	}
}