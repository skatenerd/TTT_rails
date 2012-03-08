class PagesController < ApplicationController

  def game
    @title="Gametime"
    @stylesheets=[params[:action]]

    board_object=Board.new()

    game_id_param=params[:game_id]

    game_record=nil
    if game_id_param
      game_record=GameRecord.find(game_id_param)
    end
    

    coordinates_param=params[:coordinates]
    if coordinates_param and coordinates_param.length==2
      coordinates=coordinates_param.split("").map{|x|Integer(x)}
      if game_record
        game_record.move_records.create(:row=>coordinates[0],:col=>coordinates[1],:player=>"x")
      end
    end
    #@board=board_object.board_vector
    #@winner=board_object.get_winner()

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
