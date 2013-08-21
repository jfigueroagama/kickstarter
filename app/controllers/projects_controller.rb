class ProjectsController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user, only: :destroy
  
  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      flash[:success] = "Project created!"
      redirect_to root_path
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @project.destroy
    redirect_to root_path
  end
  
  private
  
  def project_params
    params.require(:project).permit(:name, :description)
  end
  
  def correct_user
    # checks if the current_user has the project
    @project = current_user.projects.find_by(id: params[:id])
    redirect_to root_path if @project.nil?
  end
  
end
