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
      # byebug
      target_node.parent.children.reject! { |child| child== self } unless target_node.parent == nil
    end
  end

  def add_child(child_node)

  end

end

n1 = PolyTreeNode.new("root1")
n2 = PolyTreeNode.new("root2")
n3 = PolyTreeNode.new("root3")
n3.parent = n1
# connect n3 to n2
n3.parent = n2
#
# # this should work
# raise "Bad parent=!" unless n3.parent == n2
# raise "Bad parent=!" unless n2.children == [n3]
#
# # this probably doesn't
# raise "Bad parent=!" unless n1.children == []
