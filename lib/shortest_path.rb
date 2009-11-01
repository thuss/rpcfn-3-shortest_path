module ShortestPath
  
  NODES = 0..1 # Nodes are in positions 0 and 1 ['A', 'B', 20]
  LENGTH = 2   # Lenght is in position 2 
  INFINITY = 1.0/0 # http://weblog.jamisbuck.org/2007/2/7/infinity
  
  # Adds distance method to Array to compute the distance of the current path 
  class Path < Array
    def distance
      (size > 0)? inject(0) { | sum, edge | sum += edge[LENGTH] } : INFINITY
    end
  end
  
  # Takes a start node ('A'), end node ('B'), and array of edges ([['A','B',10], ['A','B',20]]).
  # Returns edges representing the shortest path ([['A','B',10]]) using Dijkstra's algorithm
  def shortest_path(start_node, end_node, all_edges)
    adjacent_edges = all_edges.select{ | edge | edge[NODES].include?(start_node) }
    remaining_edges = all_edges - adjacent_edges
    shortest_path = nil
    
    # Iterate over the adjacent edges and recursively compute optimal path ahead
    adjacent_edges.each do | edge |
      path = Path.new [edge]
      neighbor_node = (edge[NODES] - [start_node])[0] # ['A', 'B'] - ['A'] => 'B'
      unless neighbor_node == end_node
        path_ahead = shortest_path(neighbor_node, end_node, remaining_edges) # Recurse ahead
        (path_ahead.nil?)? path = nil : path.concat(path_ahead)
      end      
      shortest_path = path if shortest_path.nil? || !path.nil? && path.distance < shortest_path.distance
    end
    
    shortest_path
  end
  
end