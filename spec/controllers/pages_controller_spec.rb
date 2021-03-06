require 'spec_helper'
require 'game_playback_helper'

describe PagesController do
  render_views

  describe "GET 'menu'" do
    it "should be successful" do
      get 'menu'
      response.should be_success
    end

    it "should display difficulty menu" do
      get 'menu'
      response.should have_selector("div", :name=> "newGame")
      response.body.should include "Unbeatable"
    end
  end

  describe "POST 'game_playback" do
    before(:each) do
      game_record=GameRecord.new(:first_player=>:human)
      game_record.save
      game_record.move_records.create(:row=>0,:col=>0,:player=>"x")
      game_record.move_records.create(:row=>0,:col=>1,:player=>"x")
      game_record.move_records.create(:row=>0,:col=>2,:player=>"x")
    end

    it "should be successful" do
      post('game_playback',{:game_id=>1,:turn=>0})
      response.should be_success
    end

    it "should not display the left arrow at turn 0" do
      post('game_playback',{:game_id=>1,:turn=>0})
      response.body.should_not include "&lt;--"
      response.body.should include "--&gt;"
    end
  end

  describe "GET 'game_listings'" do
    it "should be successful" do
      get 'game_listings'
      response.should be_success
    end

  end

  describe "POST 'new-game'" do
    it "should be successful" do
      post('new_game',{:first_player=>:human,:difficulty=>:unbeatable})
      response.should be_success
    end
    
   it "adds to database according to request" do
      post('new_game',{:first_player=>:human,:difficulty=>:unbeatable})
      GameRecord.all.count.should ==1
      game_record=GameRecord.find(1)
      game_record.max_depth.should ==Game.get_maxdepth(:unbeatable)
      game_record.first_player.intern.should ==:human
    end

   it "builds a board with a move on it" do
      post('new_game',{:first_player=>:cpu,:difficulty=>:unbeatable})
      GameRecord.all.count.should ==1
      game_record=GameRecord.find(1)
      game_record.max_depth.should ==Game.get_maxdepth(:unbeatable)
      game_record.first_player.intern.should ==:cpu
      game_record.move_records.count.should ==1
    end
  end

  describe "POST 'game'" do
    before(:each) do
      game_record=GameRecord.new(:first_player=>:cpu)
      game_record.save
      game_record.move_records.create(:row=>0,:col=>0,:player=>"x")
    end

    it "should be successful" do
      post('game',{:game_id=>1,:coordinates=>22,:player=>"o"})
      response.should have_selector("title", :content=> "Gametime")
    end
    
    it "should add a round to the current game" do
      Board.any_instance.stub(:get_cpu_move).and_return([0,2])
      post('game',{:game_id=>1,:coordinates=>22,:player=>"o"})
      game_record=GameRecord.find(1)
      game_record.move_records.count.should ==3
      game_record.move_records.last.player.should =="x"
      game_record.move_records.last.row.should ==0
      game_record.move_records.last.col.should ==2
    end
   
    it "does not display links for occupied squares" do
      post('game',{:game_id=>1,:coordinates=>22,:player=>"o"})
      response.body.should_not include('a href="/game?board_id=2&amp;coordinates=00')
      response.body.should_not include('a href="/game?board_id=2&amp;coordinates=22')
    end

    it "displays victory message when gets a terminated game" do
      Board.any_instance.stub(:get_outcome).and_return("X")

      post('game',{:game_id=>1,:coordinates=>"02",:player=>"x"})
      response.should have_selector("div",:name=>"outcome")
      response.body.should_not include('href="/game?')
    end

  end

end

#
#
  #end
#end
