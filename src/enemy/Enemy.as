package enemy
{
	import flash.geom.Point;
	
	import behaviours.AStarNode;
	
	import starling.display.Sprite;

	public class Enemy
	{
		public var hp:Number;
		public var dmg:Number;
		public var sprite:Sprite;
		public var bMarkedForDestroy:Boolean;
		
		private var m_route:Route;
		private var m_rerouteCounter:int;
		
		private var m_speed:Number;
		private var m_angle:Number;
		private var m_velocityX:Number;
		private var m_velocityY:Number;
		
		private static var m_helperTargetPos:Point = new Point();
		
		public function Enemy(route:Route)
		{
			bMarkedForDestroy = false;
			sprite = new Sprite();
			GM.enemies.push(this);
			GM.layerGame.addChild(sprite);
			
			m_route = route;
			m_rerouteCounter = 0;
			
			sprite.x = m_route.spawnX;
			sprite.y = m_route.spawnY;
			
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
		
		public function explode():void
		{
			bMarkedForDestroy= true;
			
			// throw particles
		}
		
		public function update():void
		{
			sprite.x += m_velocityX;
			sprite.y += m_velocityY;
			
			m_rerouteCounter--;
			if(m_rerouteCounter < 0)
			{
				refreshVelocityFromRoute();
		}
		
			if(GM.castle.containsPos(sprite.x, sprite.y))
			{
				GM.castle.enteredByEnemy(this);
				explode();
			}
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
		
		private function refreshVelocityFromRoute():void
		{
			// pick the node which is closes to me
			var dx:int;
			var dy:int;
			var distSq:Number;
			var closest:Number = Number.MAX_VALUE;
			var closestIndex:int = 0;
			for(var r:int = 0; r < m_route.path.length; r++)
			{
				// compare center of tile with sprite position
				dx = (m_route.path[r].x + 0.5) * GM.tileWidth - sprite.x;
				dy = (m_route.path[r].y + 0.5) * GM.tileHeight - sprite.y;
				distSq = dx*dx+dy*dy;
				if(distSq < closest)
				{
					closest = distSq;
					closestIndex = r;
				}
				else // getting further
				{
					break;
				}
			}
			
			// reaching the end
			var targetIndex:int = (closestIndex >= m_route.path.length-1) ? closestIndex : closestIndex + 1;
			
			// move towards next node position
			
			m_helperTargetPos.x = (m_route.path[targetIndex].x + 0.5) * GM.tileWidth;
			m_helperTargetPos.y = (m_route.path[targetIndex].y + 0.5) * GM.tileHeight;
			
			// finally set the angle based on the target, don't change speed
			m_helperTargetPos.y -= sprite.y;
			m_helperTargetPos.x -= sprite.x;
			angle = Math.atan2( m_helperTargetPos.y, m_helperTargetPos.x) * 180 / Math.PI;
			
			m_rerouteCounter = (m_helperTargetPos.length / speed) + Math.random() * 3;
		}

		public function sustainDamage(damage:Number):void
		{
			hp -= damage;
			if (hp < 0)
			{
				explode();
			}
		}
	}
}