module ShortestPath
  
  NODES = 0..1 # Nodes are in positions 0 and 1 ['A', 'B', 20]
  LENGTH = 2   # Length is in position 2 
  INFINITY = 1.0/0 # http://weblog.jamisbuck.org/2007/2/7/infinity
  
  # Adds distance method to compute the distance of the current path 
  class Path < Array
    def distance
      (any?)? inject(0) { | sum, edge | sum += edge[LENGTH] } : INFINITY
    end
  end

  # Returns the unused edges between start_node and end_node
  def unused_paths(start_node, end_node, all_edges)
    all_edges - shortest_path(start_node, end_node, all_edges)
  end

  # Returns the shortest path between start_node and end_node
  def shortest_path(start_node, end_node, all_edges)
    adjacent_edges = all_edges.select{ | edge | edge[NODES].include?(start_node) }
    remaining_edges = all_edges - adjacent_edges
    shortest_path = Path.new
    adjacent_edges.each do | edge |
      path = Path.new [edge]
      neighbor_node = (edge[NODES] - [start_node])[0] # ['A', 'B'] - ['A'] => ['B']
      unless neighbor_node == end_node
        path_ahead = shortest_path(neighbor_node, end_node, remaining_edges)
        (path_ahead.empty?)? path.clear : path.concat(path_ahead)
      end      
      shortest_path = path if path.distance < shortest_path.distance
    end
    shortest_path
  end
      
end