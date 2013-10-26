class Admin::CoursesController < ApplicationController
  before_filter :require_user
  before_filter :require_admin

  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end

  private

  
  def require_admin
    if !current_user.admin?
      flash[:error] = "You are not authorized to do that."
      redirect_to home_path
    end
  end
end
