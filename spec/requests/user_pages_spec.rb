require 'spec_helper'

describe "User Pages" do
  
  subject { page }
  
  describe "Signup page" do
    before { visit signup_path }
    
    it {should have_content('Sign up')}   
  end
  
  describe "Show page" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      visit user_path(user)
    end
    
    it { should have_selector('h1', text: user.name)}
  end
end
