class Video < ActiveRecord::Base
 mount_uploader :video_url, VideoUrlUploader 

  belongs_to :chapter
  validates_presence_of :title, :description, :mins, :secs, :video_url

end
