require 'spec_helper'

describe GameListingsHelper do
  it "builds a link" do
    game={:board=>"xxxxxxxxx",:id=>1}
    build_game_link(game).should include "a href=\"/game_playback?game_id=1&amp;turn=1"
    build_game_link(game).should include "xxxxxxxxx"
  end
end
