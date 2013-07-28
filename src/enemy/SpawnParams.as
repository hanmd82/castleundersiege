package enemy
{

	public class SpawnParams
	{
		public var spawnClass:Class;
		public var frame:int;
		public var route:Route;
		
		public function SpawnParams(
			newSpawnClass:Class, newframe:int, 
			newRoute:Route)
		{
			spawnClass = newSpawnClass;
			frame = newframe;
			route = newRoute;
		}
	}
}