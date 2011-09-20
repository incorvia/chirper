require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do
    @base_title = "Chirper App"
  end
  
  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
  end
  
  describe "Get 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
  end 
  
  describe "Get 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end
  end
  
  describe "Title Test: Home" do
    it "it should have the right title" do
      get 'home'
      response.should have_selector("title", :content => @base_title + " | Home")
    end
  end

  describe "Title Test: About" do
    it "it should have the right title" do
      get 'about'
      response.should have_selector("title", :content => @base_title + " | About")
    end
  end
  
  describe "Title Test: Contact" do
    it "it should have the right title" do
      get 'contact'
      response.should have_selector("title", :content => @base_title + " | Contact")
    end
  end
  
  describe "Title Test: Help" do
    it "it should have the right title" do
      get 'help'
      response.should have_selector("title", :content => @base_title + " | Help")
    end
  end    
end