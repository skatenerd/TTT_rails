class PagesController < ApplicationController

  def game
    @title="Gametime"
    @stylesheets=[params[:action]]
    @board=[["z","o","x"],["o","o","o"],["x","o","x"]]
  end
  def about
    @title="About"
    @stylesheets=[]
  end
end
