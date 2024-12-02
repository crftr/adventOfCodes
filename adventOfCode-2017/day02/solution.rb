class Checksummer

  def initialize(input_file = './input.txt')
    @file = input_file
  end

  def checksum1
    line_diffs = 0

    File.open(@file, 'r') do |f|
      f.each_line do |line|
        row_nums = line.split(/\D/)
        row_nums.map!(&:to_i)
        
        min = row_nums.min
        max = row_nums.max

        line_diffs += (max - min)
      end
    end

    line_diffs
  end

  def checksum2
    line_diffs = 0

    File.open(@file, 'r') do |f|
      f.each_line do |line|
        row_nums = line.split(/\D/)
        row_nums.map!(&:to_i)

        winner =
          row_nums.permutation(2).find do |p|
            (p[0] / p[1]) == (p[0].to_f / p[1].to_f)
          end

        line_diffs += winner[0] / winner[1]
      end
    end

    line_diffs
  end
end

puts Checksummer.new('./test.txt').checksum2
puts Checksummer.new.checksum2