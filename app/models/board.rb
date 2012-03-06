class Board
  attr_accessor :board
  def initialize(initial_board)
    @board=initial_board
  end

  def self.default_board
   [["*","*","*"],["*","*","*"],["*","*","*"]]
  end

  def self.get_board(board)
    if(board.nil?)
      default_board
    else
      eval(board)
    end
  end

  def self.get_player(player)
    if(player.nil?)
      "X"
    else
      player
    end
  end


end
