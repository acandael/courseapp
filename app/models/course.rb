class Course < ActiveRecord::Base
  has_many :chapters
  validates_presence_of :title, :description
end
