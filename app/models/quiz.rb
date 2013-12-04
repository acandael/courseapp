class Quiz < ActiveRecord::Base
  belongs_to :chapter
  has_many :questions, dependent: :delete_all
  validates_presence_of :title

  has_many :quiz_completions
  has_many :users, through: :quiz_completions
end
