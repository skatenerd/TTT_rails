require 'spec_helper'

describe PagesController do
  render_views

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
      first_board=BoardRecord.new(:board=>"xx  o abc")
      first_board.save
      second_board=BoardRecord.new(:board=>"x  oxo   ")
      second_board.save
      game_record=GameRecord.new()
      game_record.save
      game_record.move_records.create(:row=>0,:col=>0,:player=>"x")
    end

    it "should add a move association to the current game" do
      #bebimbap = BoardRecord.new(:row=>0,:col=>0,:player=>"x")
      post('game',{:board_id=>2,:game_id=>1,:coordinates=>22})
      game_record=GameRecord.find(1)
      game_record.move_records.count.should ==2
      
      


    end

    it "should be successful" do
      post('game',{:board_id=>1})
      response.should have_selector("title", :content=> "Gametime")
    end
    
  
   it "should display the board that was sent" do
      post('game',{:board_id=>1})
      response.should have_selector("div", :name=> "boardContainer") do |container|
        container.should contain("o")
        container.should contain("x")
        container.should contain(" ")
        container.should contain("a")
        container.should contain("b")
        container.should contain("c")
      end
    end

    it "displays victory message when gets a terminated game" do
      post('game',{:board_id=>2,:coordinates=>22})
      response.should have_selector("div",:name=>"winner")
      response.body.should_not include('a href="/game?board_id=2&amp;coordinates=')
    end

    it "does not display links for occupied squares" do
      post('game',{:board_id=>2,:coordinates=>22})
      response.should have_selector("div",:name=>"winner")
      response.body.should_not include('a href="/game?board_id=2&amp;coordinates=00')
    end
  end
end


#
#
#
  #describe "GET 'about'" do
    #it "should be successful" do
      #get 'about'
      #response.should be_success
    #end
  #end
#end
