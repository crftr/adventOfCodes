class SpiralMemory

  def initialize(input)
    @input = input
  end

  def number_of_steps
    return 0 if @input == 1

    sqrt_of_odd_square      = sqrt_of_next_odd_square(@input)
    sqrt_of_prev_odd_square = sqrt_of_odd_square - 2
    odd_square              = sqrt_of_odd_square ** 2
    length_of_ring_side     = sqrt_of_odd_square - 1

    # First axis
    #
    distance_from_ring_to_center = (sqrt_of_odd_square / 2).floor
    
    # Second axis
    #
    distance_map_to_pivot = 
      (-distance_from_ring_to_center...distance_from_ring_to_center).to_a.map(&:abs)

    distance_to_closest_ring_pivot =
      distance_map_to_pivot[(@input - sqrt_of_prev_odd_square ** 2) % length_of_ring_side]

    return distance_from_ring_to_center + distance_to_closest_ring_pivot
  end
 
  private

  def sqrt_of_next_odd_square(n)
    candidate = Math.sqrt(n).ceil
    if candidate.odd?
      candidate
    else
      candidate + 1
    end
  end
end

print "Input for Day3 Part 1: "
input = gets.to_i

steps = SpiralMemory.new(input).number_of_steps
puts "#{steps} steps"