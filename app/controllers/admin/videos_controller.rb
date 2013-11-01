class Admin::VideosController < ApplicationController
  before_filter :require_user
  before_filter :require_admin
  
  def new
    @video = Video.new
    @chapter = Chapter.find(params[:chapter_id])
  end

  def create
    @video = Video.create(video_params(params[:video]))
    if @video.save
      flash[:success] = "You created a new video, '#{ @video.title }' for chapter #{ @video.chapter_id }."
      redirect_to admin_chapter_path(@video.chapter_id)
    else
      flash[:error] = "The video could not be created. Please check the error messages."
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

  def video_params(param)
    params.require(:video).permit(:title, :description, :video_url, :mins, :secs, :chapter_id)
  end
end
