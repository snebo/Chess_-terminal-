# frozen_string_literal: true

require_relative './chess_pieces'

# class String
#   def bg_brown; "\e[40m#{self}\e[0m" end
#   def bg_grey; "\e[47m#{self}\e[0m]" end
# end

# TODO: add the move set to each piece

# this should hold the game logic
class Chess
  def initialize(first_player, second_player)
    @pl1 = first_player
    @pl2 = second_player
    @board = Array.new(8) {Array.new(8, '-')}

    game_setup
  end

  def game_setup
    w_p1 = Pawn.new('white')
    w_p2 = Pawn.new('white')
    w_p3 = Pawn.new('white')
    w_p4 = Pawn.new('white')
    w_p5 = Pawn.new('white')
    w_p6 = Pawn.new('white')
    w_p7 = Pawn.new('white')
    w_p8 = Pawn.new('white')

    w_kg = King.new('white')
    w_q = Queen.new('white')
    w_b1 = Bishop.new('white')
    w_r1 = Rook.new('white')
    w_kn1 = Knight.new('white')
    w_b2 = Bishop.new('white')
    w_r2 = Rook.new('white')
    w_kn2 = Knight.new('white')
    white_pieces = [w_p1, w_p2, w_p3, w_p4, w_p5, w_p6, w_p7, w_p8,
                    w_r1, w_kn1, w_b1, w_q, w_kg, w_b2, w_kn2, w_r2]
    # set white pieces position and locations
    k = 0
    (6..7).each do |i|
      j = 0
      while j < @board[i].length
        @board[i][j] = white_pieces[k]
        # puts "[#{i}, #{j}] : #{white_pieces[k].value}"
        white_pieces[k].curr_loc = [i, j]
        k += 1; j += 1
      end
    end

    b_p1 = Pawn.new('black')
    b_p2 = Pawn.new('black')
    b_p3 = Pawn.new('black')
    b_p4 = Pawn.new('black')
    b_p5 = Pawn.new('black')
    b_p6 = Pawn.new('black')
    b_p7 = Pawn.new('black')
    b_p8 = Pawn.new('black')

    b_kg = King.new('black')
    b_q = Queen.new('black')
    b_b1 = Bishop.new('black')
    b_r1 = Rook.new('black')
    b_kn1 = Knight.new('black')
    b_b2 = Bishop.new('black')
    b_r2 = Rook.new('black')
    b_kn2 = Knight.new('black')
    black_pieces = [b_r1, b_kn1, b_b1, b_q, b_kg, b_b2, b_kn2, b_r2,
                    b_p1, b_p2, b_p3, b_p4, b_p5, b_p6, b_p7, b_p8]
    # set black posiiton
    k = 0
    [0, 1].each do |i|
      j = 0
      while j < @board[i].length
        @board[i][j] = black_pieces[k]
        # puts "[#{i}, #{j}] : #{black_pieces[k].value}"
        black_pieces[k].curr_loc = [i, j]
        j += 1; k += 1
      end
    end
  end

  def print_lst_pices(pl, val)
    return (' '*pl.name.length) if pl.lost_pieces.empty?
    
    print "#{pl.lost_pieces[val]} "
    pl.lost_pieces[val + 1].nil? ? '' : pl.lost_pieces[val + 1]
  end

  def draw_board(board = @board)
    system('cls') || system('clear')
    cols = '    a   b   c   d   e   f   g   h'
    rows = [1, 2, 3, 4, 5, 6, 7, 8]
    line = '  ---------------------------------'
    mpt = ' |  '; space = '        '; div_space = '  |  '; k = 0
    puts line + space + @pl1.name + div_space + @pl2.name

    lst_pice = space + print_lst_pices(@pl1, k) + div_space + print_lst_pices(@pl2, k)

    rows.reverse.each_with_index do |val, row|
      print val
      # print the value of the baord
      (0..7).each do |col|
        curr = board[row][col]
        curr == '-' ? print(mpt) : print(" | #{curr.value}")
      end
      print " |#{lst_pice}\n#{line}\n"
      k += 2
    end
    puts cols
  end
end

class Player
  attr_reader :name, :color
  attr_accessor :lost_pieces
  def initialize(name, color)
    @name = name
    @color = color
    @lost_pieces = []
  end
end

# general access module
def yes_or_no(message)
  reply = ''
  loop do
    print "#{message}(y/n): "
    reply = gets.chomp
    break if ['y', 'n'].any?(reply.chr)
  end
  reply == 'y' ? (return true): (return false)
end

# start
puts 'Hi, welcome to terminal chess!!!'
person1 = ''; person2 = ''; s_board = ''; chess_game = ''
# load game or start afresh
if yes_or_no('would you line to load a game?')
  load_game(person1, person2, s_board)
  chess_game = Chess..new(person1, person2, s_board)
else
  print 'Player1 enter your name: '
  name1 = gets.chomp
  print "\nPlayer2 enter your name: "
  name2 = gets.chomp
  person1 = Player.new(name1, 'black')
  person2 = Player.new(name2, 'white')
  chess_game = Chess.new(person1, person2)
end

chess_game.draw_board
