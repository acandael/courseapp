class Video < ActiveRecord::Base
  belongs_to :chapter
  validates_presence_of :title, :description, :mins, :secs, :video_url

  mount_uploader :video_url, VideoUrlUploader

end
