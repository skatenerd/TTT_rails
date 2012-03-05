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
  end



  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
  end


end
