class Course < ActiveRecord::Base
  has_many :chapters, dependent: :delete_all
  validates_presence_of :title, :description

  mount_uploader :image, CourseImageUploader
end
