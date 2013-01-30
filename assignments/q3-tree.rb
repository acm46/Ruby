class Tree
  attr_accessor :children, :node_name

  def initialize(*args)

    if args[0].class == Hash
      hash = args[0]
      @node_name = hash.first.first
      children = []
      if hash.first[1] != {}
        hash.first[1].each do |key,val|
          children.push(Tree.new({key => val}))
        end
      end
      @children = children
    else
      @node_name = args[0]
      @children = args[1] ? args[1] : [] 
    end

  end

  def visit_all(&block)
    visit &block
    children.each {|c| c.visit_all &block}
  end

  def visit(&block)
    block.call self
  end

end

ruby_tree = Tree.new("Ruby", [Tree.new("Reia"),
Tree.new("MacRuby")])

ruby_tree_two = Tree.new({
  'grandpa' => {
    'dad' => {
      'child 1' => {},
      'child 2' => {}
    },
    'uncle' => {
      'child 3' => {}, 
      'child 4' => {}
    }
  }
})

puts "Visiting a node from Array Tree"
ruby_tree.visit {|node| puts node.node_name}
puts

puts "visiting entire tree from Array Tree"
ruby_tree.visit_all {|node| puts node.node_name}
puts

puts "Visiting a node from Hash Tree"
ruby_tree_two.visit {|node| puts node.node_name}
puts

puts "visiting entire tree from Hash Tree"
ruby_tree_two.visit_all {|node| puts node.node_name}