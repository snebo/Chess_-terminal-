class Player
  attr_reader :name, :color
  attr_accessor :lost_pieces

  def initialize(name, color)
    @name = name
    @color = color
    @lost_pieces = []
  end
end
