package projectile
{
	import enemy.Enemy;

	import flash.geom.Point;

	import starling.display.Sprite;

	public class Projectile
	{
		// shoot out of towers and travel in a straight line towards a pre-defined location (maybe we can have hunter seeker projectiles later)
		public var damage:Number;
		public var damageRadius:Number;
		public var targetPos:Point;
		public var sprite:Sprite;
		public var bMarkedForDestroy:Boolean; // when a projectile hits an object, update damage AOE and flag to remove from stage
		
		private var m_speed:Number;
		private var m_angle:Number;
		private var m_velocityX:Number;
		private var m_velocityY:Number;
		
		public function Projectile()
		{
			bMarkedForDestroy = false;
			sprite = new Sprite();
			GM.projectiles.push(this);
			GM.layerGame.addChild(sprite);
			
			m_speed = 0;
			m_angle = 0;
			m_velocityX = 0;
			m_velocityY = 0;
		}
		
		public function checkCollision():Vector.<Enemy>
		{
			// hit something along the trajectory from source to destination
			// projectiles currently pass through one another

			var projectilePos:Point = new Point(sprite.x, sprite.y);
			var enemiesHit:Vector.<Enemy> = new Vector.<Enemy>();

			for each (var e:Enemy in GM.enemies)
			{
				var enemyPos:Point = new Point(e.sprite.x, e.sprite.y);
				var distance:Number = Point.distance(projectilePos, enemyPos);
				if (distance < sprite.width/2 + e.sprite.width/2)
				{
					enemiesHit.push(e);
				}
			}
			return enemiesHit;
		}

		public function dealDamage(enemiesHit:Vector.<Enemy>):void{}

		public function destroy():void
		{
			bMarkedForDestroy = true;
			if(sprite)
			{
				sprite.removeFromParent(true);
				sprite = null;
			}
		}
		
		public function update():void
		{
			sprite.x += m_velocityX;
			sprite.y += m_velocityY;
			
			if (sprite.x > GM.canvasWidth || sprite.y > GM.canvasHeight)
			{
				destroy();
			}
			else
			{
				var enemiesHit:Vector.<Enemy> = checkCollision();
				if (enemiesHit.length != 0)
				{
					dealDamage(enemiesHit);
					destroy();
				}
			}
		}
		
		public function get speed():Number { return m_speed; }
		public function get angle():Number { return m_angle; }
		public function get vx():Number { return m_velocityX; }
		public function get vy():Number { return m_velocityY; }
		
		public function set speed(value:Number):void { m_speed = value, refreshVelocityFromSpeedAngle(); }
		public function set angle(value:Number):void { m_angle = value, refreshVelocityFromSpeedAngle(); }
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
