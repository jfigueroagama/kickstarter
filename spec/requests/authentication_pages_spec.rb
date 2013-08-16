require 'spec_helper'

describe "Authentication Pages" do
  
  subject { page }
  
  describe "Signin page" do
    before { visit signin_path }
    
    describe "with invalid information" do
      before { click_button "Sign in" }
      
      it { should have_content('Sign in') }
      it { should have_selector('title', text: 'Sign in') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }
      
      #describe "after visiting another page" do
      #  before { click_link 'Home' }
        
      #  it { should_not have_selector{ 'div.alert.alert-error'} }
      #end
    end
    
    describe "with valid information" do
      before do
        @user = User.new(name: "Josue Figueroa", email: "josue@example.com", password: "foobar", password_confirmation: "foobar")
        @user.save
      end
      before do
        fill_in "Email", with: @user.email.upcase
        fill_in "Password", with: @user.password
        click_button "Sign in"
      end
      
      it { should have_selector('title', text: @user.name) }
      #it { should have_link('Profile', href: user_path(@user)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
    end
  end
end
