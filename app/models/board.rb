require 'net/http'
class Board
  attr_accessor :board_record
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
    old_vector[coordinates[0]][coordinates[1]]=new_value.to_s
    flattened=old_vector.flatten
    array_of_characters=flattened.map{|square|
      if square.nil?
        " "
      else
        square.to_s
      end}  
    new_string=array_of_characters.join("")
    @board_record.update_attribute(:board,new_string)
  end

  def update_for_human_cpu_round(coordinates)
    update(coordinates,:x)
    cpu_move=get_cpu_move(:o)
    if cpu_move
      update(cpu_move,:o)
    end
  end

  def board_from_string(board_string)
    flat_array=board_string.split("")
    board_array=[]
    3.times do |row|
      board_array<<flat_array.shift(3).map{|x|
        if x==" "
          nil
        else
          x.to_sym
        end}
    end
    board_array
  end

  def board_string
    @board_record.board
  end

  def get_cpu_move(player)
    postdata=("board="+board_string+"&player="+player.to_s).downcase
    respdata=make_ttt_request(postdata,"/ttt/cpumove")
    move=nil
    if(respdata.length>0)
      move=respdata[-2,2].split("")
      move=move.map{|x|Integer(x)}
    end
    return move 
  end

  def get_winner()
    winner=nil
    postdata=("board="+board_string).downcase
    respdata=make_ttt_request(postdata,"/ttt/winner")
    if respdata.length==1
      winner=respdata
    elsif board_string.gsub(" ","").length==9
      winner="TIE"
    end
  end

  def make_ttt_request(postdata,url)
    http=Net::HTTP.new("localhost",8080)
    resp,respdata=http.post(url,postdata)
    respdata
  end

end
