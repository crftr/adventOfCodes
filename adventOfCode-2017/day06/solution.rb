require 'set'

class Redistributor

  INITIAL_STATE = [5, 1, 10, 0, 1, 7, 13, 14, 3, 12, 8, 10, 7, 12, 0, 6]

  def initialize(starting_state = INITIAL_STATE)
    @banks = starting_state
    @number_of_banks = @banks.count
  end

  def redistributions_until_match_is_found
    Set.new.tap do |seen|
      until seen.include?(@banks.to_s)
        seen << @banks.to_s
        distribute_from(find_next_index)
      end
    end
  end

  private

  def find_next_index
    @banks.find_index(@banks.max)
  end

  def distribute_from(idx)
    remaining_to_distribute = @banks[idx]

    @banks[idx] = 0

    (1..remaining_to_distribute).each do |j|
      @banks[(idx + j) % @number_of_banks] += 1
    end
  end
end

# p Redistributor.new([0,2,7,0]).redistributions_until_match_is_found.size # 5

r = Redistributor.new
p r.redistributions_until_match_is_found.size # part1
p r.redistributions_until_match_is_found.size # part2