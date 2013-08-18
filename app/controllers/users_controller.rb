class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user, only: [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Kickstarter!"
      redirect_to @user # here we can also use user_path(user)
    else
      render 'new'
    end
  end
  
  def edit
    # This is done in before_ filter correct_user method
    #@user = User.find(params[:id])
  end
  
  def update
    # This is done in before_filter correct_user method
    #@user = User.find(params[:id])
    # user_params are "strong parameters" defined in user model introduced in Rails 4
    if @user.update_attributes(user_params)
      sign_in @user
      flash[:success] = "Profile updated!"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def signed_in_user
    unless signed_in?
      flash[:notice] = "Please sign in"
      redirect_to signin_path
    end
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end
  
end
