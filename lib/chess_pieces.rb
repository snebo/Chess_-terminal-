# frozen_string_literal: true

# create chess pieces
# handle chess piece information and moveset

# each chess piece should store their location and next possible locations

class Pawn
  def initialize(position, color)
    @pos = position
    @sym = color == 'black' ? 'B' : 'W'
    #set the position of the
    @curr_pos = position
  end
  
end