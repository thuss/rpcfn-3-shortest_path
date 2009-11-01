require File.dirname(__FILE__) + '/spec_helper.rb'

describe ShortestPath do
  include ShortestPath

  it "should return nil if we can't complete the path" do
    edges = [[ 'A', 'B', 50]]
    shortest_path('A', 'X', edges).should be_nil
  end
  
  it "should find the shortest path with only 2 nodes and 1 edge" do
    edges = [[ 'A', 'B', 50]]
    shortest_path('A', 'B', edges).should eql(edges)
  end
  
  it "should find the shortest path with multiple legs but only one path" do
    edges = [[ 'A', 'B', 50], ['B', 'C', 50], ['C', 'D', 50]]
    path = shortest_path('A', 'D', edges)
    path.should eql(edges)
    path.distance.should eql(150)
  end
  
  it "should find the shortest path with 2 nodes and 2 edges" do
    short = [['A', 'B', 40]]
    long = [['A', 'B', 50]]
    edges = short + long
    path = shortest_path('A', 'B', edges)
    path.should eql(short)
    path.distance.should eql(40)
  end

  it "should find the shortest path with multiple legs and multiple routes" do
    short = [['A', 'D', 20], ['D', 'E', 5]] # 25
    long = [[ 'A', 'B', 10], ['B', 'C', 10], ['B', 'Z', 1], ['C', 'E', 10]] # 30
    edges = short + long
    path = shortest_path('A', 'E', edges)
    path.should eql(short)
    path.distance.should eql(25)
  end
end
