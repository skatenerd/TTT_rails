class PagesController < ApplicationController

  def game
    @title="Gametime"
    @stylesheets=[params[:action]]

    board_id_param=params[:board_id]
    if board_id_param
      board_record=BoardRecord.find(board_id_param)
    else
      board_record=nil
    end


    board_object=Board.new(board_record)
    @board_id=board_object.board_record.id


    coordinates_param=params[:coordinates]
    if coordinates_param and coordinates_param.length==2
      coordinates=coordinates_param.split("").map{|x|Integer(x)}
      board_object.update_for_human_cpu_round(coordinates)
    end
    @board=board_object.board_vector
    @winner=board_object.get_winner()

  end
  def about
    @title="About"
    @stylesheets=[]
  end

  #def updateGame
  #  render(:update) do |page|
  #    page.replace_html('boardContainer', partial: 'board', :object => [["z","z","z"],["zbbb","o","o"],["x","o","x"]])
  #  end
  #end

end
