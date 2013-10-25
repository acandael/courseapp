class CoursesController < ApplicationController
  before_filter :require_user
  def index
    course = Course.first
    redirect_to course_path(course)
  end
  def show
    @course = Course.find(params[:id])
  end
end
