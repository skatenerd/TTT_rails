require 'spec_helper'

describe GamePlaybackHelper do
  it "builds a link" do
    game={:board=>"xxxxxxxxx",:id=>1}
    build_playback_link(game).should include "a href=\"/game_playback?game_id=1&amp;turn=1"
    build_playback_link(game).should include "xxxxxxxxx"
  end

  it "builds the next-move link" do
    build_next_link(1,1).should include "a href=\"/game_playback?game_id=1&amp;turn=2"
  end
  it "builds the previous-move link" do
    build_previous_link(1,2).should include "a href=\"/game_playback?game_id=1&amp;turn=1"
  end
end
