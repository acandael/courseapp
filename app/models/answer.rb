class Answer < ActiveRecord::Base
  belongs_to :question
  validates_presence_of :title
  validates_uniqueness_of :is_correct, scope: :question_id, conditions: -> { where(is_correct: true) }
end
