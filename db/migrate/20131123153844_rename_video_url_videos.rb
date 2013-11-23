class RenameVideoUrlVideos < ActiveRecord::Migration
  def change
    rename_column :videos, :remote_video_url, :video
  end
end
