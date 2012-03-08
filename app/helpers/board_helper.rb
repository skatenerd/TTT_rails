module BoardHelper

  def buildGameLink(text,coordinates,board_id)
    url=Rails.application.routes.url_helpers.game_path(:coordinates=> coordinates.to_s, :board_id=>board_id.to_s)
    link_to(text,url,:method=>:post).html_safe
  end

  def visible_text(text)
    if(text==" ")
      "*"
    else
      text
    end
  end
    

end
