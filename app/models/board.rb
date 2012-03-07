require 'net/http'
class Board
  attr_accessor :board_record
  EmptyCharacter="*"
  def initialize(board_record)
    if(board_record.nil?)
      @board_record=BoardRecord.new
      @board_record.save()
    else
      @board_record=board_record
    end
  end

  def board_vector
    board_from_string(@board_record.board)
  end

  def update(coordinates,new_value)
    old_vector=board_vector
    old_vector[coordinates[0]][coordinates[1]]=new_value
    new_string=old_vector.flatten.to_s
    @board_record.update_attribute(:board,new_string)
  end

  def board_from_string(board_string)
    flat_array=board_string.split("")
    board_array=[]
    3.times do |row|
      board_array<<flat_array.shift(3) 
    end
    board_array
  end

end

#
  #def updated(coordinate,value)
    #cloned=clone
    #cloned[coordinate[0]][coordinate[1]]=value
    #cloned
  #end
#
  #def clone
    #cloned=[]
    #@board.each do |row|
      #cloned<<row.clone
    #end
    #cloned
  #end
#
  #def future_boards(player)
    #boards=Hash.new()
    #@board.count.times do |row_index|
      #row=@board[row_index]
      #row.count.times do |col_index|
        #coordinate=[row_index,col_index]
        #if(@board[row_index][col_index]==EmptyCharacter)
          #after_human_move=Board.new(updated(coordinate,player))
          #cpu_move=after_human_move.get_cpu_move(Board.other_player(player))
          #if cpu_move
            #after_cpu_move=Board.new(after_human_move.updated(cpu_move,Board.other_player(player)))
            #boards[coordinate]=after_cpu_move.board
          ##else
            ##boards[coordinate]=after_human_move.board
          #end
        #end
      #end
    #end
    #boards
  #end
#
  #def self.postdata_string(board)
    #flattened_string=board.flatten.to_s
    #flattened_string.gsub(EmptyCharacter," ")    
  #end
#
  #def get_cpu_move(player)
    #board_string=Board.postdata_string(@board)
    #postdata=("board="+board_string+"&player="+player).downcase
    #http=Net::HTTP.new("localhost",8080)
    #resp,respdata=http.post("/ttt/cpumove",postdata)
    #move=nil
    #if(respdata.length>0)
      #move=respdata[-2,2].split("")
      #move=move.map{|x|Integer(x)}
    #end
    #return move 
  #end
#
#
#
  #def self.other_player(player)
    #if player.upcase=="O"
      #"X"
    #elsif player.upcase=="X"
      #"O"
    #end
  #end
#
#
#
#
#
  #def self.default_board
   #Board.new([[EmptyCharacter,EmptyCharacter,EmptyCharacter],
              #[EmptyCharacter,EmptyCharacter,EmptyCharacter],
              #[EmptyCharacter,EmptyCharacter,EmptyCharacter]])
  #end
#
  #def self.board_from_string(board_string)
    #if(board_string.nil?)
      #default_board
    #else
      #Board.new(eval(board_string))
    #end
  #end
#
  #def self.get_player(player)
    #if(player.nil?)
      #"X"
    #else
      #player
    #end
  #end
#
#end