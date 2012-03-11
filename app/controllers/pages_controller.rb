class PagesController < ApplicationController
  FirstPlayer="x"
  def game

    action_param=params[:action]
    game_id_param=params[:game_id]
    player_param=params[:player]
    coordinates_param=params[:coordinates]
    difficulty_param=params[:difficulty]
    
    board_object=Board.new()
    game=Game.new(game_id_param,extract_difficulty(difficulty_param))
    coordinates=extract_coordinates(coordinates_param)
    player=extract_player(player_param)
    game.update_for_human_cpu_round(coordinates,player.intern)

    @coordinates=coordinates
    @board=game.board_vector
    @game_id=game.id
    @player=player
    @winner=game.board_object.get_winner()
    @stylesheets=[action_param]
    @title="Gametime"

  end

  def menu
    @title="Main Menu"
    @stylesheets=[]
    @stats=Game.stats

  end

  def extract_difficulty(difficulty_param)
    if difficulty_param
      difficulty_param.intern
    end
  end

  def extract_coordinates(coordinates_param)
    if coordinates_param and coordinates_param.length==2
      coordinates_param.split("").map{|x|Integer(x)}
    else
      nil
    end
  end

  def extract_player(player_param)
    if player_param
      @player=player_param
    else
      @player=FirstPlayer
    end
  end

  def about
    @title="About"
    @stylesheets=[]
  end

end
