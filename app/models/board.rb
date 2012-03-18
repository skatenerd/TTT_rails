require 'net/http'
class Board
  attr_accessor :board_vector
  def initialize()
    @board_vector=[[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]]
  end

  def update(coordinates,new_value)
    @board_vector[coordinates[0]][coordinates[1]]=new_value
  end

  def board_string
    @board_vector.flatten.map{|x|
      if x.nil?
        " "
      else
        x.to_s
      end}.join("")
  end

  def printable_string
    board_string.gsub(" ","_")
  end


  def make_ttt_request(postdata,url)
    http=Net::HTTP.new("deep-stone-3472.herokuapp.com")
    resp,respdata=http.post(url,postdata)
    respdata
  end

  def get_cpu_move(player,maxdepth)
    postdata=("board="+board_string+"&player="+player.to_s).downcase
    if maxdepth
      postdata+="&maxdepth="+maxdepth.to_s.downcase
    end
    respdata=make_ttt_request(postdata,"/ttt/cpumove")
    move=nil
    if(respdata.length>0)
      move=respdata[-2,2].split("")
      move=move.map{|x|Integer(x)}
    end
    return move 
  end

  def board_full?
    board_string.gsub(" ","").length==9
  end

  def get_outcome()
    winner=nil
    postdata=("board="+board_string).downcase
    respdata=make_ttt_request(postdata,"/ttt/winner")
    if respdata.length==1
      winner=respdata
    elsif board_full?
      winner="TIE"
    end
  end

end

