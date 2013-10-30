class Admin::ChaptersController < ApplicationController
  before_filter :require_user
  before_filter :require_admin

  def index
    @course = Course.find(params[:course_id])
  end
  def new
    @chapter = Chapter.new
    @course = Course.find(params[:course_id])
  end
  
  def create
    @chapter = Chapter.create(chapter_params(params[:chapter]))
    if @chapter.save
      flash[:success] = "You created a new chapter, '#{ @chapter.title }' for course #{ @chapter.course_id }"
      redirect_to edit_admin_course_path(@chapter.course_id)
    else
      flash[:error] = "You could not create a new chapter. Please check the error messages."
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

  def chapter_params(param)
    params.require(:chapter).permit(:title, :description, :course_id, :tagline, :badge_image)
  end
end
