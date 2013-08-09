require 'spec_helper'

describe "Static Pages" do
  describe "Home Page" do
    before { visit root_path }
    
    subject { page }
    
    
    it { should have_selector('h1', :text => 'Welcome to Kickstarter') }
    it { should have_selector('title', :text => 'Home') }
    
  end
end
