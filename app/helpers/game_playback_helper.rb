module GamePlaybackHelper
  def build_playback_link(game)
    link_to(game[:board],get_playback_url(game[:id],1),:method=>:post).html_safe
  end

  def build_next_link(game_id,current_turn)
    link_to("--->",get_playback_url(game_id,current_turn+1),:method=>:post).html_safe
  end

  def build_previous_link(game_id,current_turn)
    link_to("<---",get_playback_url(game_id,current_turn-1),:method=>:post).html_safe
  end

  def get_playback_url(game_id,turn)
    Rails.application.routes.url_helpers.game_playback_path(:game_id=>game_id, :turn=>turn)
  end
end
