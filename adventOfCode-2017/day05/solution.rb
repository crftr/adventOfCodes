class Jumper

  attr_reader :jump_count

  def initialize(input_file: './input.txt', complex_jumps: false)
    @file          = input_file
    @complex_jumps = complex_jumps
    
    load_instructions
    @instruction_count = @instructions.count

    @jump_count = 0
    @jump_idx   = 0
  end

  def execute
    jump until jumped_out?
  end

  private

  def jump
    get_current_jump_value

    if @complex_jumps
      increment_current_jump_value_part2
    else
      increment_current_jump_value
    end

    increment_jump_count

    @jump_idx += @jump_value
  end

  def jumped_out?
    @jump_idx >= @instruction_count
  end

  def get_current_jump_value
    @jump_value = @instructions[@jump_idx]
  end

  def increment_current_jump_value
    @instructions[@jump_idx] += 1
  end

  def increment_current_jump_value_part2
    if @jump_value >= 3
      @instructions[@jump_idx] -= 1
    else
      @instructions[@jump_idx] += 1
    end
  end

  def increment_jump_count
    @jump_count += 1
  end

  def load_instructions
    @instructions = []

    File.open(@file, 'r') do |f|
      f.each_line do |line|
        @instructions << line.to_i
      end
    end
  end
end

j = Jumper.new
j.execute

puts "#{j.jump_count} jumps (part1)"

j2 = Jumper.new(complex_jumps: true)
j2.execute

puts "#{j2.jump_count} jumps (part2)"
