class Admin::VideosController < ApplicationController
  before_filter :require_user
  before_filter :require_admin

  def show
    @video = Video.find(params[:id])
    @chapter = Chapter.find(@video.chapter_id)
  end
  
  def new
    @video = Video.new
    @chapter = Chapter.find(params[:chapter_id])
    @video.chapter_id = @chapter.id
  end

  def create
    @video = Video.create(video_params)
    @video.chapter_id = params[:chapter_id]
    @chapter = Chapter.find(@video.chapter_id)
    if @video.save
      flash[:success] = "You created a new video, '#{ @video.title }' for chapter #{ @video.chapter_id }."
      redirect_to admin_chapter_path(@video.chapter_id)
    else
      flash[:alert] = "The video could not be created. Please check the error messages."
      render :new
    end
  end

  def edit
    @video = Video.find(params[:id])
    @chapter = Chapter.find(@video.chapter_id)
  end

  def update
    @video = Video.find(params[:id])
    @chapter = Chapter.find(@video.chapter_id)
    if @video.update_attributes(video_params)
      flash[:success] = "You successfully updated video '#{@video.title}'."
      redirect_to admin_chapter_video_path(params[:chapter_id], params[:id])
    else
      flash[:alert] = "The video was not updated. Please check the error messages."
      render :edit
    end
  end

  def destroy
    video = Video.find(params[:id])
    if video.destroy
      flash[:success] = "You successfully deleted video #{ video.title}."
      redirect_to admin_chapter_path(params[:chapter_id])
    end
  end

  private

  def require_admin
    if !current_user.admin?
      flash[:alert] = "You are not authorized to do that."
      redirect_to home_path
    end
  end

  def video_params
    params.require(:video).permit(:title, :description, :video, :mins, :secs, :chapter_id)
  end
end
