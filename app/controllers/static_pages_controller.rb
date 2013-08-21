class StaticPagesController < ApplicationController
  def home
    @project = current_user.projects.build if signed_in?
  end
end
