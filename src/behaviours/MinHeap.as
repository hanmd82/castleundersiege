package behaviours
{
	/**
	 * Implemented as a binary heap
	 */
	public class MinHeap
	{
		private var m_array:Vector.<AStarNode>;
		
		public function MinHeap()
		{
			m_array = new Vector.<AStarNode>();
		}
		
		public function clear():void
		{
			while(m_array.length > 0)
				m_array.pop();
		}
		
		public function getMin():AStarNode
		{
			return (m_array.length == 0) ? null : m_array[0];
		}
		
		public function empty():Boolean
		{
			return (m_array.length == 0);
		}
		
		public function add(value:AStarNode):void
		{
			// Add the element to the bottom level of the heap.
			m_array.push(value);
			
			var currIndex:int = m_array.length-1;
			var parentIndex:int = parent(currIndex);
			while(parentIndex != currIndex &&
				// Compare the added element with its parent; if they are in the correct order, stop.
				m_array[currIndex].f_score < m_array[ parentIndex ].f_score)
			{
				// If not, swap the element with its parent and return to the previous step.
				swap(currIndex, parentIndex);
				currIndex = parentIndex;
				parentIndex = parent(currIndex);
			}
		}
		
		public function removeMin():void
		{
			// Replace the root of the heap with the last element on the last level.
			var last:AStarNode = m_array.pop();
			m_array[0] = last;
			// Compare the new root with its children; if they are in the correct order, stop.
			minHeapify(0);
		}
		
		public function find(value:AStarNode):Boolean
		{
			// find using astarnode x,y
			// so have to do manually
			for(var i:int = m_array.length-1; i >= 0; i--)
			{
				if(m_array[i].id == value.id)
				{
					return true;
				}
			}
			return false;
		}
		
		private function minHeapify(index:int):void
		{
			var left:int = childLeft(index);
			var right:int = childRight(index);
			var smallest:int = index;
			
			if ( left < m_array.length && m_array[left] < m_array[smallest] )
				smallest = left;
			if ( right < m_array.length && m_array[right] < m_array[smallest] )
				smallest = right;
			
			if (smallest != index)
			{
				swap(index, smallest);
				minHeapify(smallest);
			}
		}
		
		private function swap(i:int, j:int):void
		{
			var temp:AStarNode = m_array[i];
			m_array[i] = m_array[j];
			m_array[j] = temp;
		}
		
		private function parent(index:int):int
		{
			return ((index-1)>>1);
		}
		
		private function childLeft(index:int):int
		{
			return (index<<1) + 1;
		}
		
		private function childRight(index:int):int
		{
			return (index<<1) + 2;
		}
	}
}