class Course < ActiveRecord::Base
  has_many :course_modules
  validates_presence_of :title, :description
end
