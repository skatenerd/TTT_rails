class PagesController < ApplicationController

  def game
    @title="Gametime"
    @stylesheets=[params[:action]]

    board_object=Board.new()

    game_id_param=params[:game_id]

    game=Game.new(game_id_param)

    coordinates_param=params[:coordinates]
    if coordinates_param and coordinates_param.length==2
      coordinates=coordinates_param.split("").map{|x|Integer(x)}
        game.add_move(coordinates[0],coordinates[1],"x")
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
