class SpiralGrid

  DIRECTIONS = {
    right: { step: ->(x, y){ [x + 1, y    ] }, check: :max_x, next_direction: :up    },
    up:    { step: ->(x, y){ [x    , y + 1] }, check: :max_y, next_direction: :left  },
    left:  { step: ->(x, y){ [x - 1, y    ] }, check: :min_x, next_direction: :down  },
    down:  { step: ->(x, y){ [x    , y - 1] }, check: :min_y, next_direction: :right }
  }

  def self.coordinate_of(target)
    target_val    = target
    current_val   = 1
    current_coord = [0, 0]

    direction = :right
    max_y = 0
    min_y = 0
    max_x = 0
    min_x = 0

    while current_val != target_val

      d_obj = DIRECTIONS[direction]

      # proceed 1 step
      #
      current_coord = d_obj[:step][*current_coord]
      current_val += 1

      # check if we've gone far enough
      #
      time_to_turn =
        case d_obj[:check]
        when :max_x
          current_coord[0] == max_x + 1
        when :max_y
          current_coord[1] == max_y + 1
        when :min_x
          current_coord[0] == min_x - 1
        when :min_y
          current_coord[1] == min_y - 1
        end

      if time_to_turn
        case d_obj[:check]
        when :max_x
          max_x += 1
        when :max_y
          max_y += 1
        when :min_x
          min_x -= 1
        when :min_y
          min_y -= 1
        end

        direction = d_obj[:next_direction]
      end
    end

    current_coord
  end
end

coord = SpiralGrid.coordinate_of(347991)
p coord
p coord.reduce(0) { |sum, c| sum + c.abs }