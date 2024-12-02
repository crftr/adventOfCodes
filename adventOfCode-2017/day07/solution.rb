class CircusData

  attr_reader :nodes

  def initialize(file)
    @file  = file
    @nodes = {}

    load
  end

  def bottom_node
    @nodes.reject { |_, v| v.include? :parent }
  end

  def loaded_weight(node_name = :all)
    return loaded_weight(bottom_node.keys[0]) if node_name == :all

    children_names = @nodes[node_name][:children]

    if children_names.empty?
      @nodes[node_name][:weight]
    else
      children_weight = children_names.map { |cn| loaded_weight(cn) }.reduce(&:+)
      @nodes[node_name][:weight] + children_weight
    end
  end

  def all_children_balanced?(node_name = :all)
    return all_children_balanced?(bottom_node.keys[0]) if node_name == :all

    cw = children_weights(node_name)
    if cw.count > 1
      unbalanced = cw.select { |_, v| v.count == 1 }
      [false, unbalanced.values.flatten[0]]
    else
      [true]
    end
  end

  def children_weights(node_name)
    current = @nodes[node_name]

    current[:children].reduce({}) do |set, cn|
      child_weight = loaded_weight(cn).to_s
      if set.key?(child_weight)
        set[child_weight] << cn
      else
        set[child_weight] = [cn]
      end
      set
    end
  end

  def find_unbalanced_node(node_name = :all)
    return find_unbalanced_node(bottom_node.keys[0]) if node_name == :all

    current = @nodes[node_name]

    balance_result = all_children_balanced?(node_name)
    if balance_result[0] == true
      puts "#{node_name} is balanced"
    else
      puts  "#{node_name} is unbalanced..."
      puts  "Loaded weights: #{children_weights(node_name)}"
      print "Node weights:    "
      current[:children].each { |cn| print "#{cn}:#{@nodes[cn][:weight]} " }
      print "\n"

      current[:children].each do |cn|
        find_unbalanced_node(cn)
      end
    end
  end

  private

  def load
    File.open(@file, 'r') do |f|
      f.each_line do |line|
        add_node(*parse_line(line))
      end
    end
  end

  def parse_line(line)
    name, weight, *children = line.scan(/\w+/)

    [name.to_sym, weight.to_i, children.map(&:to_sym)]
  end

  def add_node(name, weight, children = nil)
    if @nodes[name]
      @nodes[name].merge!({ weight: weight, children: children })
    else
      @nodes[name] = { weight: weight, children: children }
    end

    children.each do |child|
      if @nodes[child]
        @nodes[child].merge!({ parent: name })
      else
        @nodes[child] = { parent: name }
      end
    end
  end
end

# cd_test = CircusData.new('test_input.txt')
# cd_test.find_unbalanced_node

cd = CircusData.new('input.txt')
cd.find_unbalanced_node
