require 'spec_helper'

describe GameListingsHelper do
  class SelfShunt
  end

  before(:each) do
    @shunt=SelfShunt.new()
    @shunt.extend(GameListingsHelper)
  end

  game={:board=>"xxxxxxxxx",:id=>1}
  @shunt.build_game_link(game).should =="<a href=/game_listings?game=xxxxxxxxx&turn=1>"
end
