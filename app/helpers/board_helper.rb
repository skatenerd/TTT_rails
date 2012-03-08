module BoardHelper

  def build_td(text,coordinates,game_id)#,winner)
    if empty_square(text)# and (not winner)
      url=Rails.application.routes.url_helpers.game_path(:coordinates=> coordinates.to_s, :game_id=>game_id.to_s)
      link_to("*",url,:method=>:post).html_safe
    else
      text
    end
  end

  def empty_square(text)
    text.nil?
  end
    

end
