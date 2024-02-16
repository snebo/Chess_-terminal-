# frozen_string_literal: true

# create player information
# store and control player information
class Player
  attr_reader :count

  @@count = 1
  def initialize(name, color = @@count < 2 ? 'black' : 'white')
    @name = name
    @color = color
    @pieces  = []
    assign_pieces
    @@count += 1
  end

  def get_info
    puts "name: #{@name}"
    puts "color : #{@color}"
    puts "class count = #{@@count}"
  end

  def assign_pieces
    if @color == 'black'
      c = @color
      # an array of the pieces with their positions
      @pieces  = [pawn1 = Pawn.new([1,0],c), pawn2 = Pawn.new([1,1],c), pawn3 = Pawn.new([0,2],c), pawn4 = Pawn.new([0,3],c),
                  pawn5 = Pawn.new([0,4],c), pawn6 = Pawn.new([0,5],c), pawn7 = Pawn.new([0,6],c), pawn8 = Pawn.new([0,7],c)]
    end
  end
end

one = Player.new('jack')
puts one.get_info
two = Player.new('tommmy')
puts two.get_info