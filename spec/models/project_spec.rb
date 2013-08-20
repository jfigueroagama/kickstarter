require 'spec_helper'

describe Project do
  let(:user) { FactoryGirl.create(:user) }
  before do
    @project = user.projects.build(name: "My Project", description: "This is it")
  end
  
  subject { @project }
  
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  
  describe "when user_id is not present" do
    before{ @project.user_id = nil }
    it { should_not be_valid }
  end
  
  describe "when user_id is not present" do
    before { @project.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @project.name = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @project.description = " " }
    it { should_not be_valid }
  end

end
