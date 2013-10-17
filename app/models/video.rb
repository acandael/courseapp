class Video < ActiveRecord::Base
  belongs_to :course_module
  validates_presence_of :title, :mins, :secs, :video_url
end
