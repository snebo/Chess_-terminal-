require_relative './chess_pieces'

# class String
#   def bg_brown; "\e[40m#{self}\e[0m" end
#   def bg_grey; "\e[47m#{self}\e[0m]" end
# end

# TODO: write moveset for other pieces

# this should hold the game logic
class Chess
  attr_reader :board

  def initialize(first_player, second_player)
    @pl1 = first_player
    @pl2 = second_player
    @board = Array.new(8) { Array.new(8, '-') }
    @turn = true
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
    [1, 0].each do |i|
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
    [7, 6].each do |i|
      j = 0
      while j < @board[i].length
        @board[i][j] = black_pieces[k]
        # puts "[#{i}, #{j}] : #{black_pieces[k].value}"
        black_pieces[k].curr_loc = [i, j]
        j += 1; k += 1
      end
    end
  end

  def lst_pices(ply, val)
    lost = '   '
    return lost if ply.lost_pieces[val].nil?

    lost = ply.lost_pieces[val].value.to_s # add to value
    ply.lost_pieces[val + 1].nil? ? lost += ', ' : lost += " ,#{ply.lost_pieces[val + 1].value}"
    lost
  end

  def draw_board(board = @board)
    # system('cls') || system('clear')
    cols = '    a   b   c   d   e   f   g   h'
    rows = [1, 2, 3, 4, 5, 6, 7, 8]
    line = '  ---------------------------------'
    mpt = ' |  '; space = '        '; div_space = '  |  '; k = 0
    puts "#{line + space + @pl1.name}  |  #{@pl2.name}"

    # lst_pice = space + print_lst_pices(@pl1, k) + div_space + print_lst_pices(@pl2, k)

    # loop start here
    rows.reverse.each do |row|
      print row
      # print the value of the baord
      (0..7).to_a.each do |col|
        curr = board[row - 1][col]
        if curr == '*'
          print ' | *'
        else
          curr == '-' ? print(mpt) : print(" | #{curr.value}")
        end
      end
      # print " |#{lst_pice}\n#{line}\n"
      # print "  |#{space} #{print_lst_pices(@pl1, k)}#{div_space}#{print_lst_pices(@pl2, k)}
      print ' |'
      print "#{space} #{lst_pices(@pl1, k)}#{div_space}#{lst_pices(@pl2, k)}"
      print "\n#{line}\n"
      k += 2 # k is the number of taken pieces to show in a line
    end
    puts cols
  end

  def play_turn
    @turn ? play(@pl1) : play(@pl2)
    @turn = !@turn
  end

  def play(player)
    p_message = 'please select a piece to move(a1, b2,...): '
    # m_message = 'Select a spot to move to: '
    piece_select = valid_slot(player, p_message)
    piece_select = @board[piece_select[0]][piece_select[1]]
    valid_moves = update_board_possible_moves(piece_select)
    # second phase
    move_piece('Select a spot to move ', valid_moves, piece_select)
  end

  def move_piece(message, poss_move, piece)
    # move to and clear the old spot
    print_possible_moves(poss_move)
    new_position = valid_move_slot(piece, message, poss_move)
    old_position = piece.curr_loc

     # add old piece to discarded table
    old_piece = @board[new_position[0]][new_position[1]]
    if old_piece != '*'
      old_piece.color == 'white' ? @pl1.lost_pieces << old_piece : @pl2.lost_pieces << old_piece
    end

    # clear the possible move slots
    poss_move.each do |val|
      @board[val[0]][val[1]] = '-' if @board[val[0]][val[1]] == '*'
    end
    poss_move.clear

    # move the piece
    @board[new_position[0]][new_position[1]] = piece
    piece.curr_loc = new_position
    @board[old_position[0]][old_position[1]] = '-'
  end

  def print_possible_moves(poss_move)
    # print the possible moves for the piece
    return if poss_move.empty?

    letter = %w[a b c d e f g h]
    poss_move.each do |val|
      print "[#{letter[val[1]]} #{val[0] + 1}]"
    end
    puts ''
  end

  def valid_move_slot(piece,message, poss_move)
    choice = []
    loop do
      print "#{message}#{piece.name} to: "
      choice = gets.chomp
      if choice[0].match?(/[a-h]/) && choice[1].match?(/[1-8]/)
        check = convert_choice(choice)
        # puts "possible: #{poss_move}, choice: #{check}"
        break if poss_move.include?(check)
      end
    end
    puts ''
    convert_choice(choice)
  end

  def update_board_possible_moves(select_p)
    poss_move = select_p.possible_moves(@board)
    poss_move.each do |move|
      @board[move[0]][move[1]] = '*' if @board[move[0]][move[1]] == '-'
    end
    draw_board
    poss_move
  end

  def valid_slot(player, message)
    choice = []
    loop do
      print "#{player.name} #{message}"
      choice = gets.chomp
      choice = choice.split('')
      if choice[0].match?(/[a-h]/) && choice[1].match?(/[1-8]/)
        check = convert_choice(choice)
        piece = @board[check[0]][check[1]]
        if !(piece == '-')
          break if piece.color == player.color # use if and !(...)
        end
      end
    end
    puts ''
    convert_choice(choice)
  end

  def convert_choice(value)
    new_val = []
    values = %w[a b c d e f g h]
    # value = [values.index(value[0]), value[1]]
    new_val << value[1].to_i - 1
    new_val << values.index(value[0])
    new_val
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
    break if %w[y n].any?(reply.chr)
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
  person1 = Player.new(name1, 'white')
  person2 = Player.new(name2, 'black')
  chess_game = Chess.new(person1, person2)
end

in_game = true

while in_game
  chess_game.draw_board
  chess_game.play_turn
  # chess_game.check_win2
end

# check piece location on board
# chess_game.draw_board
# puts "#{chess_game.board[0][0].color} #{chess_game.board[0][0].name}"
