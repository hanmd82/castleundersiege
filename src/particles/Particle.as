package particles 
{
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;

	/**
	 * ...
	 * @author Bruce Chia
	 */
	public class Particle
	{
		protected var m_lifeRemaining:Number;
		protected var m_params:Object;
		protected var m_dob:DisplayObject;
		
		public function Particle()
		{
			m_lifeRemaining = 0;
			m_params= null;
			m_dob = null;
		}
		
		public function get displayObject():DisplayObject { return m_dob; }
		public function set displayObject(value:DisplayObject):void 
		{
			if(m_dob != null && m_dob != value && value != null)
				throw new Error("Particle:Clean up display object first!");
			m_dob = value;
			if(m_dob)
			{
				m_dob.x = -(m_dob.width>>1);
				m_dob.y = -(m_dob.height>>1);
			}
		}
		
		public function get lifeRemaining():Number { return m_lifeRemaining; }
		//public function set lifeRemaining(value:Number):void { m_lifeRemaining = value; }
		
		public function Destroy(bDispose:Boolean):void
		{
			if(m_dob != null)
			{
				if(m_dob.parent)
					m_dob.parent.removeChild(m_dob);
				m_dob = null;
			}
			
			if(m_params != null)
			{
				m_params = null;
			}
		}
		
		public function get isOn():Boolean
		{
			return (m_dob.parent != null);
		}
		
		public function On(parent:DisplayObjectContainer, params:Object):void
		{
			if(!isOn)
				parent.addChild(m_dob);
			
			m_params = params;
			m_lifeRemaining = params.life;
		}
		public function Off():void
		{
			if(m_dob.parent)
				m_dob.parent.removeChild(m_dob);
		}
		
		public function Update(elapsedTime:Number):void
		{
			m_lifeRemaining -= elapsedTime;
		}
	}

}