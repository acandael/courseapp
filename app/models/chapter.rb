class Chapter < ActiveRecord::Base
  belongs_to :course
  has_many :videos
  validates_presence_of :title, :description

end
