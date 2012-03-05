class PagesController < ApplicationController
  def game
    @title="Gametime"
    @stylesheets=["board.css"]
  end
  def about
    @title="About"
    @stylesheets=[]
  end
end
