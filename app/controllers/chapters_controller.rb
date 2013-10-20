class ChaptersController < ApplicationController
  def show
    if params[:video_id].present?
      @video = Video.find(params[:video_id])
    end
    @chapter = Chapter.find(params[:id])
  end

end
