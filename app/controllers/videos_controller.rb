class VideosController < ApplicationController
  before_filter :require_user
  def show
    @video = Video.find(params[:id])
    chapter = Chapter.find(params[:chapter_id])
    course = Course.find(chapter.course_id)
    redirect_to course_chapter_path(course_id: course.id, id: chapter.id, video_id: @video.id)
  end
end
