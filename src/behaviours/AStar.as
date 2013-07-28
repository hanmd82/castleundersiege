package behaviours
{
	

	public class AStar
	{
		private static var closedset:Object = new Object();
		private static var openset:MinHeap = new MinHeap();
		private static var came_from:Object = new Object();
		private static var g_score:Object = new Object();
		
		public function AStar()
		{
		}
		
		/**
		 * returns a path from start to goal or 
		 * null if there is no path
		 */
		public function search(start:AStarNode,goal:AStarNode):Vector.<AStarNode>
		{
			// clean closed & open set & came_from & g_score & f_score
			var key:Object;
			for (key in closedset) delete closedset[key];
			openset.clear();
			for (key in came_from) delete came_from[key];
			for (key in g_score) delete g_score[key];
			
			var current:AStarNode;
			
			// closedset = The set of nodes already evaluated.
			// closedset := the empty set
			
			// The set of tentative nodes to be evaluated, initially containing the start node
			// openset := {start}
			openset.add(start);
			
			// The map of navigated nodes.
			// came_from = the empty map    
			
			g_score[start.id] = 0    // Cost from start along best known path.
			// Estimated total cost from start to goal through y.
			start.f_score = g_score[start.id] + heuristic_cost_estimate(start, goal);
				
			trace("astar search:",start.id, goal.id);
			
			while( !openset.empty() )
			{
				// current = the node in openset having the lowest f_score[] value
				current = openset.getMin();
				
				//trace("\n\tastar current:"+current.id);
				
				if (current.id == goal.id)
					return reconstruct_path(came_from, goal)
			
				//remove current from openset
				openset.removeMin();
				//add current to closedset
				closedset[current.id] = current;
				
				var neighbor_nodes:Vector.<AStarNode> = current.getNeighbourNodes();
				// for each neighbor in neighbor_nodes(current)
				for(var n:int = 0; n < neighbor_nodes.length; n++)
				{
					var neighbor:AStarNode = neighbor_nodes[n];
					var tentative_g_score:Number = g_score[current.id] + dist_between(current,neighbor);
					
					//trace("neighbor:",neighbor.id, tentative_g_score);
					
					// if neighbor in closedset and tentative_g_score >= g_score[neighbor]
					if(closedset[neighbor.id] != null && tentative_g_score >= g_score[neighbor.id])
					{
						//trace("neighbor in closedset and tentative_g_score (",tentative_g_score,") >= gscore[neighbor] (",g_score[neighbor.id],")");
						continue;
					}
					
					// if neighbor not in openset or tentative_g_score < g_score[neighbor] 
					var bFoundNeighbor:Boolean = openset.find(neighbor);
					if(!bFoundNeighbor || tentative_g_score < g_score[neighbor.id] )
					{
						//trace("neighbor not in openset || tentative_g_score (",tentative_g_score,") < gscore[neighbor] (",g_score[neighbor.id],")");
						
						came_from[neighbor.id] = current;
						g_score[neighbor.id] = tentative_g_score;
						neighbor.f_score = g_score[neighbor.id] + heuristic_cost_estimate(neighbor, goal);
						// if neighbor not in openset
						if(!bFoundNeighbor)
						{
							//add neighbor to openset
							openset.add(neighbor);
						}
					}// end if not in openset
					
				}//end for neigher n
			}//end while(!openset.empty()
			
			return null;
		}
		
		/**
		 * returns a path using came_from to determining the most efficient route
		 * path is in order from start to goal 
		 */
		private function reconstruct_path(came_from:Object, current_node:AStarNode):Vector.<AStarNode>
		{
			var p:Vector.<AStarNode>;
			
			if(came_from[current_node.id] != null)
			{
				p = reconstruct_path(came_from, came_from[current_node.id]);
				// (p + current_node)
			}
			else
			{
				p = new Vector.<AStarNode>();
			}
			
			p.push(current_node);
			return p;
		}
		
		private function dist_between(node1:AStarNode, node2:AStarNode):Number
		{
			// manhattan distance
			return Math.abs(node1.x-node2.x) + Math.abs(node1.y-node2.y);
		}
		private function heuristic_cost_estimate(node1:AStarNode, node2:AStarNode):Number
		{
			// direct distance
			var dx:int = node1.x-node2.x;
			var dy:int = node1.y-node2.y;
			return Math.sqrt(dx*dx+dy*dy);
		}
	}
}