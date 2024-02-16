# frozen_string_literal: true

class Pawn
  attr_reader :color, :value
  attr_accessor :curr_loc

  def initialize(color, location = [])
    @color = color
    @curr_loc = location
    @has_moved = false
    @possible_moves = []
    @value = color == 'black' ? "\u2659" : "\u265F"
  end
  # should have a move function.. on the has moved should be affect moveset
end

class Rook
  attr_reader :color, :value
  attr_accessor :curr_loc
  
  def initialize(color, location = [])
    @color = color
    @curr_loc = location
    @has_moved = false
    @possible_moves = []
    @value = color == 'black' ? "\u2656" : "\u265C"
  end
end

class Bishop
  attr_reader :color, :value
  attr_accessor :curr_loc
  
  def initialize(color, location = [])
    @color = color
    @curr_loc = location
    @possible_moves = []
    @value = color == 'black' ? "\u2657" : "\u265D"
  end
end

class Knight
  attr_reader :color, :value
  attr_accessor :curr_loc
  
  def initialize(color, location = [])
    @color = color
    @curr_loc = location
    @possible_moves = []
    @value = color == 'black' ? "\u2658" : "\u265E"
  end
end

class Queen
  attr_reader :color, :value
  attr_accessor :curr_loc
  
  def initialize(color, location = [])
    @color = color
    @curr_loc = location
    @possible_moves = []
    @value = color == 'black' ? "\u2655" : "\u265B"
  end
end

class King
  attr_reader :color, :value
  attr_accessor :curr_loc
  
  def initialize(color, location = [])
    @color = color
    @curr_loc = location
    @has_moved = false
    @possible_moves = []
    @value = color == 'black' ? "\u2654" : "\u265A"
  end
end