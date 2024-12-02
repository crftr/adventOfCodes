class Stream

  attr_reader :str, :nodes

  def count_garbage(str)
    str = process_cancellations(str)

    str.scan(/<(.*?)>/)
       .flatten
       .map(&:length)
       .reduce(:+)
  end

  def count_groups(str)
    build_nodes_from_str(str)

    @nodes.group_count
  end

  def calculate_score(str)
    build_nodes_from_str(str)

    @nodes.group_score
  end

  def process_garbage_and_cancellations(str)
    process_garbage(
      process_cancellations(str))
  end

  private

  def build_nodes_from_str(str)
    @nodes = nil
    str = process_garbage_and_cancellations(str)

    parse_string(str.chars)
  end

  def parse_string(chars, parent = nil)
    return if chars.length == 0

    case chars[0]
    when '{'
      new_node = Node.new(parent)

      if parent.nil?
        @nodes = new_node
      else
        parent.children << new_node
      end

      chars.shift(1)
      parse_string(chars, new_node)
    when '}'
      chars.shift(1)
      parse_string(chars, parent&.parent)
    when ','
      chars.shift(1)
      parse_string(chars, parent)
    end
  end

  def process_cancellations(str)
    str.split(/!./).join('')
  end

  def process_garbage(str)
    str.split(/<.*?>/).join('')
  end
end

class Node
  attr_accessor :parent, :children

  def initialize(parent)
    @parent = parent
    @children = []
  end

  def depth
    if parent.nil?
      1
    else
      1 + parent.depth
    end
  end

  def group_count
    1 + (children.map(&:group_count).reduce(:+) || 0)
  end

  def group_score
    depth + (children.map(&:group_score).reduce(:+) || 0)
  end

  def to_s(level = 0)
    print "    " * level
    print "node\n"
    children.each { |c| c.to_s(level + 1) }
  end
end

File.open('input.txt', 'r') do |f|
  f.each_line do |line|
    puts "Score: #{Stream.new.calculate_score(line)}"
    puts "Garbage: #{Stream.new.count_garbage(line)}"
  end
end
