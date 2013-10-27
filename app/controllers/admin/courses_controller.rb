class Admin::CoursesController < ApplicationController
  before_filter :require_user
  before_filter :require_admin

  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.create(course_params(params[:course]))
    if @course.save
      flash[:success] = "You successfully created the course '#{ @course.title }'"
      redirect_to admin_courses_path
    else
      flash[:error] = "You cannot add this course. Please check the errors."
      render :new
    end
  end

  private

  
  def require_admin
    if !current_user.admin?
      flash[:error] = "You are not authorized to do that."
      redirect_to home_path
    end
  end

  def course_params(param)
    params.require(:course).permit(:title, :description)
  end
end
