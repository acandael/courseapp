class Video < ActiveRecord::Base
 mount_uploader :video, VideoUploader 

  belongs_to :chapter
  validates_presence_of :title, :description, :mins, :secs, :video

  has_many :watches
  has_many :users, through: :watches

end
