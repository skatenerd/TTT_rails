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

    it "should be successful" do
      post('game',{:board=>'[["a", "b", "c"],["d","e","f"],["d","e","f"]]'})
      response.should have_selector("title", :content=> "Gametime")
    end

    it "should display the board that was sent" do
      post('game',{:board=>'[["a", "b", "c"],["d","e","f"],["d","e","f"]]'})
      response.should have_selector("div", :name=> "boardContainer") do |container|
        #'abcdefdef'.each do |letter|
          #container.should contain(letter)
        #end
        container.should contain("a")
        container.should contain("b")
        container.should contain("c")
        container.should contain("d")
        container.should contain("e")
        container.should contain("f")
      end
    end


  end



  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
  end


end
