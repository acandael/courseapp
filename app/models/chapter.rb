class Chapter < ActiveRecord::Base
  belongs_to :course
  has_many :videos, dependent: :delete_all
  has_one :quiz, dependent: :delete
  validates_presence_of :title, :description

  mount_uploader :badge_image, BadgeImageUploader

end
