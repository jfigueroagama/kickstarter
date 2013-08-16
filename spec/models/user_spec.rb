require 'spec_helper'

describe User do
  before { @user = User.new(name: "Josue Figueroa", email: "josue@gmail.com", password: "foobar", password_confirmation: "foobar")}
  
  subject { @user }
  
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  
  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end
  
  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end
  
  describe "when user email is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    
    it {should_not be_valid }
  end
  
  describe "when password is not present" do
    before do
      @user = User.new(name: "Example", email: "example@gmail.com", password: " ", password_confirmation: " ")
    end
    
    it { should_not be_valid}
  end
  
  describe "when password confirmation does not match" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
  
  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end
  
  describe "return values of authenticate method" do
    before { @user.save }
    #let(:found_user) { User.find_by_email(@user.email) }
    
    describe "with valid password" do
      let(:user_with_valid_password) { @user.authenticate(@user.password) }
      
      it { should == user_with_valid_password }
      it { user_with_valid_password.should be_true }
    end
    
    describe "with invalid password" do
      let(:user_with_invalid_password) { @user.authenticate("invalid") }
      
      it { should_not == user_with_invalid_password }
      it { user_with_invalid_password.should be_false }
    end
  end
  
  describe "when password is too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    
    it { should be_invalid }
  end
  
  describe "remember token" do
    before { @user.save }
    
    # same as it but applies the test to the attribute instead of to the subject
    #its(:remember_token) { should_not be_blank }
  end
end
 