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
  def possible_moves(board)
    # one step foward if space is empty
    # two steps foward, if has not moved and space is empty
    # check if diagonal is not empty and has an opposing piece
    @possible_moves = []
    move_index = @color == 'white' ? 1 : -1

    two_step = board[curr_loc[0] + move_index + move_index][curr_loc[1]]
    if two_step == '--' && !two_step.nil? && @has_moved == false
      @possible_moves << [curr_loc[0] + move_index + move_index, curr_loc[1]]
      @has_moved = true
    end

    one_step = board[curr_loc[0] + move_index][curr_loc[1]]
    if one_step == '--' && !one_step.nil?
      @possible_moves << [curr_loc[0] + move_index, curr_loc[1]]
    end
    diagonal_left = board[curr_loc[0] + move_index][curr_loc[1] - move_index]
    if !diagonal_left.nil? && !diagonal_left == '--' && !diagonal_left.color == @color
      @possible_moves << [curr_loc[0] + move_index, curr_loc[1] - move_index]
    end
    
    diagonal_right = board[curr_loc[0] + move_index][curr_loc[1] + move_index]
    if !diagonal_right.nil? && !diagonal_right == '--' && !diagonal_right.color == @color
      @possible_moves << [curr_loc[0] + move_index, curr_loc[1] + move_index]
    end
    
  end
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