class PagesController < ApplicationController
  FirstPlayer=:x
  DefaultStylesheet="application"
  def game
    game_id_param=params[:game_id]
    player_param=params[:player]
    coordinates_param=params[:coordinates]
    
    game=Game.create_from_id(game_id_param)
    coordinates=extract_coordinates(coordinates_param)
    current_player=extract_current_player(player_param)
    game.update_for_human_cpu_round(coordinates,current_player)

    @board=game.board_vector
    @game_id=game.id
    @current_player=current_player
    @winner=game.board_object.get_winner()
    @stylesheets=extract_stylesheets("game")
    @title="Gametime"
    @stats=Game.stats
  end

  def new_game
    action_param=params[:action]
    player_param=params[:player]
    difficulty_param=params[:difficulty]

    current_player=extract_current_player(player_param)
    game=Game.create_new(extract_difficulty(difficulty_param),current_player)

    @board=game.board_vector
    @game_id=game.id
    @current_player=current_player
    @stylesheets=extract_stylesheets("game")
    @title="Gametime"

    render :action=>"game" 

  end

  def menu
    @title="Main Menu"
    @stylesheets=extract_stylesheets(nil)
    @stats=Game.stats
  end

  def extract_stylesheets(action_param)
    stylesheets=[DefaultStylesheet]
    if action_param
      stylesheets << action_param
    end
    stylesheets
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

  def extract_current_player(player_param)
    if player_param
      player=player_param.intern
    else
      player=FirstPlayer
    end
    player
  end

  def about
    @title="About"
    @stylesheets=[]
  end

end
