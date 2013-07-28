/*
* Author: Bruce Chia
* Created: Nov 4, 2012
*/
package particles 
{
	import particles.Particle;
	
	import starling.display.DisplayObjectContainer;

	/**
	 * Particle pool which is also an emitter
	 * @author Bruce Chia
	 */
	public class ParticlesPool
	{
		private var m_particles:Vector.<Particle>;
		private var m_numParticles:uint;
		private var m_currIndex:int;
//		private var m_searchMarker:int;
		private var m_parent:DisplayObjectContainer;
		private var m_emitDuration:Number;
		private var m_emitElapsed:Number;
		private var m_emitParams:Object;
		
		public function ParticlesPool(particles:Vector.<Particle>, parent:DisplayObjectContainer)
		{
			m_particles = particles;
			m_numParticles = m_particles.length;
			m_parent = parent;
			m_currIndex = 0;
			
//			m_searchMarker = 0
		}
		
		public function Destroy():void
		{
			for (var i:uint = 0; i< m_numParticles; i++) 
			{
				var p:Particle = m_particles[i];
				
				// remove particle
				p.Destroy(true);
				m_particles[i] = null;
				
			}//end for particle i
			
			
			m_particles = null;
			m_numParticles = 0;
//			m_searchMarker = 0;
		}

		public function get parent():DisplayObjectContainer { return m_parent; }
//		public function set parent(value:DisplayObjectContainer):void { m_parent = value; }

				
		public function GetParticle(index:uint):Particle { return m_particles[index]; }
		
//		public function GetAvailableParticle():Particle
//		{
//			var p:Particle = null;
//			var i:uint = m_searchMarker;
//			for (; i< m_numParticles; i++) 
//			{
//				if(!m_particles[i].isOn)
//				{
//					p = m_particles[i];
//					m_searchMarker = i+1;
//				}
//			}
//			
//			// if did not find anything, search from start again up to marker
//			if(p == null)
//			{
//				for(i = 0; i < m_searchMarker; i++)
//				{
//					if(!m_particles[i].isOn)
//					{
//						p = m_particles[i];
//						m_searchMarker = i+1;
//					}
//				}
//			}
//			
//			return p;
//		}
		
		public function OnSome(params:Object, numParticles:int = 1):void
		{
			var p:Particle;
			params.n = numParticles;
			for(var i:int = 0; i < numParticles; i++)
			{
				p = m_particles[m_currIndex];
				params.index = i;
				p.On(m_parent, params);
				m_currIndex = (m_currIndex+1) % m_numParticles;
			}
		}
		
		public function On(params:Object):void
		{
			var p:Particle;
			for (var i:uint =0; i< m_numParticles; i++) 
			{
				p = m_particles[i];
				p.On(m_parent, params);
			}
		}
		
		public function Off():void
		{
			var p:Particle;
			for (var i:uint =0; i< m_numParticles; i++) 
			{
				p = m_particles[i];
				p.Off();
			}
		}
		
		public function SetAsEmitter(emitRatePerSecond:Number, params:Object):void
		{
			m_emitDuration = 1/emitRatePerSecond;
			m_emitElapsed = 0;
			m_emitParams= params;
		}
		
		public function Update(elapsedTime:Number):void
		{
			m_emitElapsed -= elapsedTime;
			
			var p:Particle;
			for (var i:uint =0; i< m_numParticles; i++) 
			{
				p = m_particles[i];
				
				if (p.isOn)
				{
					p.Update(elapsedTime);
					
					if (p.lifeRemaining < 0)
					{
						p.Off();
					}
				}
				else if(m_emitDuration > 0 && m_emitElapsed < 0)
				{
					m_emitElapsed += m_emitDuration;
					p.On(m_parent, m_emitParams);
				}
			}//end for particle i
		}//end Update
	}

}