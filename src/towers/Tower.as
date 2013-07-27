package towers
{
	public class Tower
	{
		// TOWER TYPES
		public static const TYPE_CASTLE:String = "castle";
		public static const TYPE_GUARD:String  = "guard";
		public static const TYPE_ARCHER:String = "archer";
		public static const TYPE_CANNON:String = "cannon";
		public static const TYPE_FROST:String  = "frost";
		
		
		// TOWER ATTACK DATA
		public static const ATTACK_DAMAGE_LIGHT:uint  = 10
		public static const ATTACK_DAMAGE_MEDIUM:uint = 20
		public static const ATTACK_DAMAGE_HEAVY:uint  = 30
			
		public static const ATTACK_RANGE_NEAR:uint    = 5
		public static const ATTACK_RANGE_MEDIUM:uint  = 10
		public static const ATTACK_RANGE_FAR:uint     = 20
			
		public static const ATTACK_INTERVAL_SLOW:uint   = 20
		public static const ATTACK_INTERVAL_MEDIUM:uint = 10
		public static const ATTACK_INTERVAL_FAST:uint   = 5

		private static var x_coordinate:int;
		private static var y_coordinate:int;
		private static var attributeSet:TowerAttributeSet;

		public function Tower(x_coordinate:int, y_coordinate:int, attributeSet:TowerAttributeSet)
		{
			x_coordinate = x_coordinate;
			y_coordinate = y_coordinate;
			attributeSet = attributeSet;
		}

		public static function upgrade(tower_type:TowerAttributeSet):void
		{
			attributeSet = tower_type;
		}
	}
}