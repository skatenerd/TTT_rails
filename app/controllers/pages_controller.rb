class PagesController < ApplicationController

  def game
    @title="Gametime"
    @stylesheets=[params[:action]]
    board_object=Board.board_from_string(params[:board])
    @board=board_object.board
    @next_player=Board.get_player(params[:player])
    @future_boards=board_object.future_boards(Board.get_player(params[:player]))

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
