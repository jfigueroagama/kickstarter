require 'spec_helper'

describe "User Pages" do
  
  subject { page }
  
  describe "Signup page" do
    before { visit signup_path }
    
    let(:submit) { "Create my account" }
    
    it {should have_content('Sign up')}
    
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end
    
    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example user"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      
      it "should create an user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end   
  end
  
  describe "Show page" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      visit user_path(user)
    end
    
    it { should have_selector('h4', text: user.name)}
  end
end
