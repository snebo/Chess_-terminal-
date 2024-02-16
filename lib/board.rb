# frozen_string_literal: true

CHESS_BOARD_SIZE = 8
# create game board
# update game board
class Board
  attr_reader :board

  def initialize(size = CHESS_BOARD_SIZE)
    @pieces = { w_pawn: "\u2695", w_bishop: "\u2657", w_knight: "\u2658",
                w_rook: "\u2656", w_king: "\u2654", w_queen: "\u2655", b_pawn: "\u265F",
                b_bishop: "\u265D", b_knight: "\u265E", b_rook: "\u265C", b_king: "\u265A",
                b_queen: "\u265B"}

    @board = [%w[:w_rook :w_knight :w_bishop w_king w_queen w_bishop w_knight w_rook],
              Array.new(7,'w_pawn'),
              [nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil],
              %w[b_rook b_knight b_bishop b_king b_queen b_bishop b_knight b_rook],
              Array.new(8, 'b_pawn')]
  end

  def reset_board
    # should spawn players on one side of the board
  end

  def draw_board(board = @board)
    system('cls') || system('clear')
    cols = '    a   b   c   d   e   f   g   h'
    rows = [1, 2, 3, 4, 5, 6, 7, 8]
    line = '  ---------------------------------'
    mpt = ' |  '
    puts line
    rows.reverse.each_with_index do |val, row|
      print val
      # print the value of the baord
      (0..7).each do |col|
        curr = board[row][col]
        curr.nil? ? print(mpt) : print(" | #{@pieces[curr]}")
      end
      print " |\n#{line}\n"
    end
    puts cols
  end

  def piece(board_piece)
    
    

     case board_piece
     when 'w_pawn'
      white
     end
  end

  def set_pieces
    # takes the ar@rays from the player and fill in the spots
  end
end

board = Board.new
board.draw_board