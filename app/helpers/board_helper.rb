module BoardHelper

  def buildGameLink(text,board,player)
    url=Rails.application.routes.url_helpers.game_path(:board=> board.inspect,:player=>player)
    link_to(text,url,:method=>:post).html_safe
  end
    

end
