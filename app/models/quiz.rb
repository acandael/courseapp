class Quiz < ActiveRecord::Base
  belongs_to :chapter
  has_many :questions, dependent: :delete_all
  validates_presence_of :title
end
