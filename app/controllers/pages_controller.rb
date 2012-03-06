class PagesController < ApplicationController

  def game
    @title="Gametime"
    @stylesheets=[params[:action]]
    if params.has_key?(:board)
      @board=eval(params[:board])
    else
      @board=[["*","*","*"],["*","*","*"],["*","*","*"]]
    end
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
