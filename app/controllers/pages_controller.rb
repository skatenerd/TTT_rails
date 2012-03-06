class PagesController < ApplicationController

  def game
    @title="Gametime"
    @stylesheets=[params[:action]]
    @board=Board.get_board(params[:board])
    @player=Board.get_player(params[:player])
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
