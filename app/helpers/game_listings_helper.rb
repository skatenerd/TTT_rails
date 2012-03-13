module GameListingsHelper
  def build_game_link(game)
    url=Rails.application.routes.url_helpers.game_playback_path(:game_id=> game[:id], :turn=>1)
    link_to(game[:board],url,:method=>post).html_safe
  end
end
