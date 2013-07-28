package behaviours
{
	public class AStarNode
	{
		// grid index
		private var m_x:int;
		private var m_y:int;
		private var m_id:int;
		
		// f score
		public var f_score:Number;
		
		public function AStarNode(x:int, y:int)
		{
			m_x = x;
			m_y = y;
			// cached
			m_id = m_x*10000+m_y; 
			f_score = Number.MAX_VALUE;
		}
		
		public function get x():int { return m_x; }
		public function get y():int { return m_y; }
		public function get id():int { return m_id; }
		
		public function getNeighbourNodes():Vector.<AStarNode>
		{
			var neighbors:Vector.<AStarNode> = new Vector.<AStarNode>();
			
			// add the 8 neighbors around tile if they are empty
			
			// left side
			if(x > 0)
			{
				var xl:int = x-1;
				
				// top left
//				if(y > 0 && GM.grid[xl][y-1] == null)
//				{
//					neighbors.push(new AStarNode(xl, y-1));
//				}
				
				// left
				neighbors.push(new AStarNode(xl,y));
				
				// bottom left
//				if(y < GM.gridNumCellsY-1 && GM.grid[xl][y+1] == null)
//				{
//					neighbors.push(new AStarNode(xl, y+1));
//				}
			}
			// right side
			if (x < GM.gridNumCellsX-1)
			{
				var xr:int = x+1;
				
				// top right
//				if(y > 0 && GM.grid[xr][y-1] == null)
//				{
//					neighbors.push(new AStarNode(xr, y-1));
//				}
				
				// right
				neighbors.push(new AStarNode(xr,y));
				
				// bottom right
//				if(y < GM.gridNumCellsY-1 && GM.grid[xr][y+1] == null)
//				{
//					neighbors.push(new AStarNode(xr, y+1));
//				}
			}

			// top
			if(y > 0 && GM.grid[x][y-1] == null)
			{
				neighbors.push(new AStarNode(x, y-1));
			}
			
			// bottom
			if(y < GM.gridNumCellsY-1 && GM.grid[x][y+1] == null)
			{
				neighbors.push(new AStarNode(x, y+1));
			}
			
			return neighbors; 
		}
	}
}