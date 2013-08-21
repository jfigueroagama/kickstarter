require 'spec_helper'

describe "Project Pages" do
  
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  
  before { sign_in user }

  describe "project creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a project" do
        expect { click_button "Save" }.not_to change(Project, :count)
      end

      describe "error messages" do
        before { click_button "Save" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do

      before do
        fill_in "Name", with: "My Project"
        fill_in "Description", with: "Lorem ipsum"
      end
       
      it "should create a project" do
        expect { click_button "Save" }.to change(Project, :count).by(1)
      end
    end
  end
end
