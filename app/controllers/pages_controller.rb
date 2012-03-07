class PagesController < ApplicationController

  def game
    @title="Gametime"
    @stylesheets=[params[:action]]
    board_id=params[:board_id]
    if board_id
      board_record=BoardRecord.find(board_id)
    else
      board_record=nil
    end
    board_object=Board.new(board_record)
    @board=board_object.board_vector
    #@future_boards=board_object.future_boards(Board.get_player(params[:player]))

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
