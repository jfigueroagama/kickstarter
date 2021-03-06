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
    let!(:p1) { FactoryGirl.create(:project, user: user, name: "Preject 1", description: "My project 1") }
    let!(:p2) { FactoryGirl.create(:project, user: user, name: "Project 2", description: "My project 2") }
    before do
      visit user_path(user)
    end
    
    it { should have_selector('h4', text: user.name)}
    
    describe "projects" do
      it { should have_content(p1.name) }
      it { should have_content(p2.name) }
      it { should have_content(user.projects.count) }
    end
  end
  
  describe "Edit page" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end
    
    describe "view" do
      it { should have_content('Update your profile') }
      it { should have_selector('title', text: 'Edit user') } 
    end
    
    describe "with invalid information" do
      before { click_button "Save changes" }
      
      it { should have_content('error') }
    end
    
    describe "with valid information" do
      before do
        fill_in "Name",             with: "New name"
        fill_in "Email",            with: "new@example.com"
        fill_in "Password",         with: user.password
        fill_in "Confirmation",     with: user.password
        click_button "Save changes"
      end

      #it { should have_selector('title', text: "Edit user") }
      #it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      # this reloads the user variable from the DB and checks for the new attributes
      #specify { user.reload.name.should == "New name" }
      #specify { user.reload.email.should == "new@example.com" }
    end
  end
  
  describe "Index" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user)
      FactoryGirl.create(:user)
      visit users_path
    end

    it { should have_selector('title', text: 'All users') }
    it { should have_selector('h1',    text: 'All users') }

    it "should list each user" do
      User.all.each do |user|
        page.should have_selector('li', text: user.name)
      end
    end
    
    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          page.should have_selector('li', text: user.name)
        end
      end
    end
  end
  
end
