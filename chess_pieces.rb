# frozen_string_literal: true

class Pawn
  attr_reader :color, :value, :name
  attr_accessor :curr_loc

  def initialize(color, location = [])
    @color = color
    @name = 'pawn'
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
    move_index = @color == 'black' ? -1 : 1

    two_step = board[curr_loc[0] + (move_index + move_index)][curr_loc[1]]
    if two_step == '-' && !two_step.nil? && @has_moved == false
      @possible_moves << [curr_loc[0] + (move_index + move_index), curr_loc[1]]
      @has_moved = true
    end

    one_step = board[curr_loc[0] + move_index][curr_loc[1]]
    if one_step == '-' && !one_step.nil?
      @possible_moves << [curr_loc[0] + move_index, curr_loc[1]]
    end

    diagonal_left = board[curr_loc[0] + move_index][curr_loc[1] - move_index]
    if curr_loc[0] + move_index < 8 && curr_loc[1] < 8 && !diagonal_left.nil?
      if diagonal_left != '-' && diagonal_left.color != @color
        @possible_moves << [curr_loc[0] + move_index, curr_loc[1] - move_index]
      end
    end

    diagonal_right = board[curr_loc[0] + move_index][curr_loc[1] + move_index]
    if curr_loc[0] + move_index < 8 && curr_loc[1] < 8 && !diagonal_right.nil?
      if diagonal_right != '-' && diagonal_right.color != @color
        @possible_moves << [curr_loc[0] + move_index, curr_loc[1] + move_index]
      end
    end

    @possible_moves
  end
end

class Rook
  attr_reader :color, :value, :name
  attr_accessor :curr_loc
  
  def initialize(color, location = [])
    @color = color
    @curr_loc = location
    @name = 'rook'
    @has_moved = false
    @possible_moves = []
    @value = color == 'black' ? "\u2656" : "\u265C"
  end

  def possible_moves(board)
    @possible_moves = []
    # horizontally
    row = @curr_loc[1] + 1
    # positive
    while row < 8
      right = board[@curr_loc[0]][row]
      if !right.nil?
        if right == '-'
          @possible_moves << [@curr_loc[0], row]
        else
          # meeting a piece
          right.color == @color ? (break) : (@possible_moves << [@curr_loc[0], row]; break)
        end
      end
      row += 1
    end
    # negative
    row = @curr_loc[1] - 1
    while row >= 0
      left = board[@curr_loc[0]][row]
      if !left.nil?
        if left == '-'
          @possible_moves << [@curr_loc[0], row]
        else
          # meeting a piece
          left.color == @color ? (break) : (@possible_moves << [@curr_loc[0], row]; break)
        end
      end
      row -= 1
    end

    # vertically
    col = @curr_loc[0] + 1
    while col < 8
      front = board[col][@curr_loc[1]]
      if !front.nil?
        if front == '-'
          @possible_moves << [col, @curr_loc[1]]
        else
          # meeting a piece
          front.color == @color ? (break) : (@possible_moves << [col, @curr_loc[1]]; break)
        end
      end
      col += 1
    end
    # negative
    col = @curr_loc[0] - 1
    while col >= 0
      back = board[col][@curr_loc[1]]
      if !back.nil?
        if back == '-'
          @possible_moves << [col, @curr_loc[1]]
        else
          # meeting a piece
          back.color == @color ? (break) : (@possible_moves << [col, @curr_loc[1]]; break)
        end
      end
      col -= 1
    end
    @possible_moves
  end
end

class Bishop
  attr_reader :color, :value, :name
  attr_accessor :curr_loc
  
  def initialize(color, location = [])
    @color = color
    @curr_loc = location
    @name = 'bishop'
    @possible_moves = []
    @value = color == 'black' ? "\u2657" : "\u265D"
  end
end

class Knight
  attr_reader :color, :value, :name
  attr_accessor :curr_loc
  
  def initialize(color, location = [])
    @color = color
    @curr_loc = location
    @name = 'knight'
    @possible_moves = []
    @value = color == 'black' ? "\u2658" : "\u265E"
  end
end

class Queen
  attr_reader :color, :value, :name
  attr_accessor :curr_loc
  
  def initialize(color, location = [])
    @color = color
    @curr_loc = location
    @name = 'queen'
    @possible_moves = []
    @value = color == 'black' ? "\u2655" : "\u265B"
  end
end

class King
  attr_reader :color, :value, :name
  attr_accessor :curr_loc
  
  def initialize(color, location = [])
    @color = color
    @curr_loc = location
    @name = 'king'
    @has_moved = false
    @possible_moves = []
    @value = color == 'black' ? "\u2654" : "\u265A"
  end
end