require 'net/http'
class Board
  attr_accessor :board_vector
  def initialize()
    @board_vector=board_from_string("         ")
  end

  def update(coordinates,new_value)
    @board_vector[coordinates[0]][coordinates[1]]=new_value
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


  def board_full?
    board_string.gsub(" ","").length==9
  end

end

  #def get_cpu_move(player)
    #postdata=("board="+board_string+"&player="+player.to_s).downcase
    #respdata=make_ttt_request(postdata,"/ttt/cpumove")
    #move=nil
    #if(respdata.length>0)
      #move=respdata[-2,2].split("")
      #move=move.map{|x|Integer(x)}
    #end
    #return move 
  #end
#
#
  #def get_winner()
    #winner=nil
    #postdata=("board="+board_string).downcase
    #respdata=make_ttt_request(postdata,"/ttt/winner")
    #if respdata.length==1
      #winner=respdata
    #elsif board_full?
      #winner="TIE"
    #end
  #end
#
  #def make_ttt_request(postdata,url)
    #http=Net::HTTP.new("localhost",8080)
    #resp,respdata=http.post(url,postdata)
    #respdata
  #end
#
  #def update_for_human_cpu_round(coordinates)
    #update(coordinates,:x)
    #cpu_move=get_cpu_move(:o)
    #if cpu_move
      #update(cpu_move,:o)
    #end
  #end
#
#end

