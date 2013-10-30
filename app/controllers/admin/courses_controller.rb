class Admin::CoursesController < ApplicationController
  before_filter :require_user
  before_filter :require_admin

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(course_params(params[:course]))
      flash[:success] = "You successfully update course '#{ @course.title }'"
      redirect_to admin_courses_path
    else
      flash[:error] = "You cannot update this record. Please check the errors."
      render :edit 
    end
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

  def destroy
    course = Course.find(params[:id])
    course.destroy
    flash[:success] = "You successfully deleted course '#{ course.title }'."
    redirect_to admin_courses_path
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
