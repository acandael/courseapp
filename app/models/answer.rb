class Answer < ActiveRecord::Base
  belongs_to :question
  validates_presence_of :title
  validates_uniqueness_of :correct, scope: :question_id, conditions: -> { where(correct: true) }
end
