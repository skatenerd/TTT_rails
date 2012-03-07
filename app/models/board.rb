class Board
  attr_accessor :board
  EmptyCharacter="*"
  def initialize(initial_board)
    @board=initial_board
  end


  def updated(coordinate,value)
    cloned=clone
    cloned[coordinate[0]][coordinate[1]]=value
    cloned
  end

  def clone
    cloned=[]
    @board.each do |row|
      cloned<<row.clone
    end
    cloned
  end

  def future_boards(player)
    boards=Hash.new()
    @board.count.times do |row_index|
      row=@board[row_index]
      row.count.times do |col_index|
        coordinate=[row_index,col_index]
        if(@board[row_index][col_index]==EmptyCharacter)
          boards[coordinate]=updated(coordinate,player)
        end
      end
    end
    boards

  end



  def self.other_player(player)
    if player.upcase=="O"
      "X"
    elsif player.upcase=="X"
      "O"
    end
  end





  def self.default_board
   Board.new([[EmptyCharacter,EmptyCharacter,EmptyCharacter],
              [EmptyCharacter,EmptyCharacter,EmptyCharacter],
              [EmptyCharacter,EmptyCharacter,EmptyCharacter]])
  end

  def self.board_from_string(board_string)
    if(board_string.nil?)
      default_board
    else
      Board.new(eval(board_string))
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
