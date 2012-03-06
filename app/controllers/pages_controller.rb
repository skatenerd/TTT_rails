class PagesController < ApplicationController

  def game
    @title="Gametime"
    @stylesheets=[params[:action]]
  end
  def about
    @title="About"
    @stylesheets=[]
  end
end
