require 'spec_helper'

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

  describe "GET 'game'" do

    it "should be successful" do
      get 'game'
      response.should be_success
    end

    it "should have the right title" do
      get 'game'
      response.should have_selector("title", :content => "Gametime")
    end

    it "should have a board" do
      get 'game'
      response.should have_selector("div", :name=> "boardContainer")
    end
  end

  describe "POST 'game'" do
    before(:each) do
      game_record=GameRecord.new()
      game_record.save
      game_record.move_records.create(:row=>0,:col=>0,:player=>"x")
    end

    it "should be successful" do
      post('game',{:board_id=>1})
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
      Board.any_instance.stub(:get_winner).and_return("X")

      post('game',{:game_id=>1,:coordinates=>"02",:player=>"x"})
      response.should have_selector("div",:name=>"winner")
      response.body.should_not include('href="/game?')
    end

  end

end

#
#
  #end
#end
