class PagesController < ApplicationController

  def game
    @title="Gametime"
    @stylesheets=[params[:action]]

    board_object=Board.new()

    game_id_param=params[:game_id]

    player_param=params[:player]

    game=Game.new(game_id_param)

    coordinates_param=params[:coordinates]
    if coordinates_param and coordinates_param.length==2
      coordinates=coordinates_param.split("").map{|x|Integer(x)}
        #game.add_move(coordinates[0],coordinates[1],player_param)
        game.update_for_human_cpu_round(coordinates[0],coordinates[1],player_param)
    end
    @board=game.board_vector
    @game_id=game.id
    if player_param
      @player=Game.other_player(player_param.intern).to_s
    else
      @player="x"
    end
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
