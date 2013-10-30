class Chapter < ActiveRecord::Base
  belongs_to :course
  has_many :videos
  has_one :quiz
  validates_presence_of :title, :description

  mount_uploader :badge_image, BadgeImageUploader

end
