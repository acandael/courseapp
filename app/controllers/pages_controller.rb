class PagesController < ApplicationController
  def front
    course = Course.first
    redirect_to course_path(course) if current_user
  end
end
