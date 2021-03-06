class PagesController < ApplicationController
  FirstPlayer=:human
  DefaultStylesheet="application"
  def game
    game_id_param=params[:game_id]
    coordinates_param=params[:coordinates]
    
    game=Game.create_from_id(game_id_param)
    coordinates=extract_coordinates(coordinates_param)
    game.update_for_human_cpu_round(coordinates)

    @board=game.board_vector
    @game_id=game.id
    @outcome=game.board_object.get_outcome()
    @should_build_link=!(@outcome.nil?)
    @stylesheets=extract_stylesheets("game")
    @title="Gametime"
    @stats=Game.stats
  end

  def game_playback
    game_id_param=params[:game_id]
    turn_param=params[:turn]
    
    game=Game.create_from_id(game_id_param)
    turn=extract_turn(turn_param)
    
    @game_id=game.id
    @board=game.board_vector_at_turn(turn)
    @turn=turn
    @first_player=game.first_player
    @title="Game Playback"
    @stylesheets=extract_stylesheets("game")
    @can_step_forward=game.can_step_forward(turn)
    @can_step_backward=game.can_step_backward(turn)
  end

  def new_game
    action_param=params[:action]
    first_player_param=params[:first_player]
    difficulty_param=params[:difficulty]

    first_player=first_player_param.intern
    game=Game.create_new(extract_difficulty(difficulty_param),first_player)

    @board=game.board_vector
    @should_build_link=false
    @game_id=game.id
    @stylesheets=extract_stylesheets("game")
    @title="Gametime"

    render :action=>"game" 
  end

  def game_listings
    @stylesheets=extract_stylesheets(nil)
    @stats=Game.detailed_stats
    @title="Game Listings"
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

  def extract_turn(turn_param)
    if turn_param
      Integer(turn_param)
    end
  end

  def extract_coordinates(coordinates_param)
    if coordinates_param and coordinates_param.length==2
      coordinates_param.split("").map{|x|Integer(x)}
    else
      nil
    end
  end


  def about
    @title="About"
    @stylesheets=[]
  end

end
