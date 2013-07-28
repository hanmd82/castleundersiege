package enemy
{

	public class Wave
	{
		protected var m_spawnSchedule:Vector.<SpawnParams>;
		protected var m_currFrame:int;
		public var endDelayFrames:int;
		
		public function Wave()
		{
			m_spawnSchedule = new Vector.<SpawnParams>();
			m_currFrame = 0;
			endDelayFrames = 60;
		}
		
		public function destroy():void
		{
			while(m_spawnSchedule.length> 0)
				m_spawnSchedule.pop();
		}
		
		public function get isEnded():Boolean
		{
			return (m_spawnSchedule.length == 0 && endDelayFrames <= 0);
		}
		
		public function add(value:SpawnParams):void
		{
			// insert sort
			var i:int = 0;
			for(i = m_spawnSchedule.length-1; i >=0; i--)
			{
				if(m_spawnSchedule[i].frame <= value.frame)
					break;
			}
			
			m_spawnSchedule.splice(i+1,0, value);
		}
		
		public function update():void
		{
			m_currFrame++;
			
			if(m_spawnSchedule.length == 0)
			{
				endDelayFrames--;
			}
			else
			{
				while(m_spawnSchedule.length > 0 && m_spawnSchedule[0].frame <= m_currFrame)
				{
					var params:SpawnParams = m_spawnSchedule.shift();
					new params.spawnClass(params);
				}
			}
		}
	}
}