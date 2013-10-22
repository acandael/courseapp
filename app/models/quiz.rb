class Quiz < ActiveRecord::Base
  belongs_to :chapter
  has_many :questions
  validates_presence_of :title
end
