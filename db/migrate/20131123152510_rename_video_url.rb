class RenameVideoUrl < ActiveRecord::Migration
  def change
    rename_column :videos, :video_url, :remote_video_url
  end
end
