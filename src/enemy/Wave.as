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
		
		public function get isEnded():Boolean
		{
			return (m_spawnSchedule.length == 0 && endDelayFrames <= 0);
		}
		
		public function add(value:SpawnParams):void
		{
			m_spawnSchedule.push(value);
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