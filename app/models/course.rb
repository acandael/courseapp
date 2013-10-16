class Course < ActiveRecord::Base
  has_many :modules
  validates_presence_of :title, :description
end
