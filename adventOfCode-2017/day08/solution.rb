class Registers

  attr_reader :registers, :recorded_max_value

  def initialize(file)
    @file = file
    @registers = Hash.new(0)
    @recorded_max_value = 0

    load
  end

  def max_register_value
    @registers.max { |a, b| a[1] <=> b[1] }
  end

  private

  def load
    File.open(@file, 'r') do |f|
      f.each_line do |line|
        process_instruction_and_condition(parse_line(line))
      end
    end
  end

  def parse_line(line)
    tokens = line.split(' ')

    {
      op_reg:     tokens[0],
      op:         tokens[1],
      op_amount:  tokens[2],
      cond_reg:   tokens[4],
      cond_comp:  tokens[5],
      cond_value: tokens[6]
    }
  end

  def process_instruction_and_condition(h)
    process_instruction(h) if condition_true?(h)
  end

  def condition_true?(h)
    reg_value  = @registers[h[:cond_reg]].to_i
    test_value = h[:cond_value].to_i

    case h[:cond_comp]
    when '>'
      reg_value > test_value
    when '<'
      reg_value < test_value
    when '>='
      reg_value >= test_value
    when '<='
      reg_value <= test_value
    when '=='
      reg_value == test_value
    when '!='
      reg_value != test_value
    else
      raise "unnkown cond_comp #{h[:cond_comp]}"
    end
  end

  def process_instruction(h)
    case h[:op]
    when 'inc'
      @registers[h[:op_reg]] += h[:op_amount].to_i
    when 'dec'
      @registers[h[:op_reg]] -= h[:op_amount].to_i
    end

    max = max_register_value[1]
    if max > @recorded_max_value
      @recorded_max_value = max
    end
  end
end

rt = Registers.new('./test_input.txt')
puts rt.registers
puts rt.max_register_value
puts "recorded max"
puts rt.recorded_max_value

r1 = Registers.new('./input.txt')
puts r1.registers
puts r1.max_register_value
puts "recorded max"
puts r1.recorded_max_value
