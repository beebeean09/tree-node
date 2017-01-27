require 'byebug'

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
