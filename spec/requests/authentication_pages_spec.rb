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
      
      it { should have_link('Users', href: users_path) }
      #it { should have_link('Profile', href: user_path(@user)) }
      #it { should have_link('Settings', href: edit_user_path(@user)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
    end
  end
  
  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('title', text: 'Sign in') }
        end

        describe "submitting to the update action" do
          # This form substitutes "visit" capybara method
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end
        
        describe "visiting the user index" do
          # The user should be signed in before visiting the index page
          before { visit users_path }
          it { should have_selector('title', text: 'Sign in') }
        end
      end
    end
    
    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user) }
      before { sign_in user }

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_selector('title', text: 'Edit user') }
      end

      describe "submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        # specify { response.should redirect_to(root_path) }
      end
    end
  end
  
end
