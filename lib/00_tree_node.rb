require 'byebug'

class KnightPathFinder
  DELTAS = [[-2,-1],[-1,2],[1,2],[2,1],[2,-1],[1,-2],[-1,-2],[-2,-1],[-2,1],[-1,2]]
  attr_reader :valid_moves

  def initialize(starting_pos)
    @starting_pos = starting_pos
    @visited_positions = [starting_pos]
    build_move_tree
  end

  def build_move_tree

  end

  # def bfs(target_value)
  #   queue = [self]
  #
  #   until queue.empty?
  #     current_node = queue.shift
  #     return current_node if current_node.value == target_value
  #     queue += current_node.children
  #   end
  # end

  def valid_moves(pos)
    valid_moves =[]
    DELTAS.each do |delta_pair|
        valid_moves << [delta_pair[0] + pos[0], delta_pair[1] + pos[1]]
    end
    valid_moves.reject! { |coord| coord.any? { |x| x < 0 || x > 8} }
  end

  def new_move_positions(pos)
    # new_moves = valid_moves(pos).reject! { |delta_pair| @visited_positions.include?(delta_pair)}
    # byebug
    new_positions = []
    valid_moves(pos).each do |delta_pair|
      if !@visited_positions.include?(delta_pair)
        new_positions << delta_pair
      end
    end
    @visited_positions.concat(new_positions)
    new_positions
  end

end

class PolyTreeNode

  def initialize(value = nil)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(target_node)

    if target_node.nil?
      @parent = nil
    else
      @parent = target_node
      target_node.children << self unless target_node.children.include?(self)
      target_node.parent.children.reject! { |child| child == self } unless target_node.parent == nil
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise 'Error: Node is not a child!' if !self.children.include?(child_node)
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value

    self.children.each do |child|
      result = child.dfs(target_value)
      return result unless result.nil?
    end

    nil
  end

  def bfs(target_value)
    queue = [self]

    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target_value
      queue += current_node.children
    end
  end
end

kpf = KnightPathFinder.new([0, 0])
p kpf.valid_moves([3,3])
