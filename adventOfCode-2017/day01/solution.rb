
input = ''

File.open('./input.txt', 'r') do |f|
  f.each_line do |line|
    input = line
  end
end

class SumSequential

  def initialize(input_str)
    @input = input_str
  end

  def sum1
    score = 0
    
    string_length  = @input.length
    scan_to_idx    = string_length - 1

    (-1...scan_to_idx).each do |idx|

      idx_1 = idx
      idx_2 = idx + 1

      if @input[idx_1] == @input[idx_2]
        score += @input[idx].to_i
      end
    end

    score
  end

  def sum2
    score = 0
    
    string_length  = @input.length
    half_of_length = string_length / 2

    scan_to_idx    = string_length - 1

    (-1...scan_to_idx).each do |idx|

      idx_1 = idx
      idx_2 = (idx + half_of_length) % string_length

      if @input[idx_1] == @input[idx_2]
        score += @input[idx].to_i
      end
    end

    score
  end
end

puts SumSequential.new(input).sum1
puts SumSequential.new(input).sum2
