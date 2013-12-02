class Quiz < ActiveRecord::Base
  belongs_to :chapter
  has_many :questions, dependent: :delete_all
  validates_presence_of :title

  has_many :quiz_completions
  has_many :users, through: :quiz_completions

  def self.pass?(quiz_id, user)
    quiz = Quiz.find(quiz_id)
    wrong_answers = 0
    quiz.questions.each do |question|
      answer = user.answers.where("question_id = ?", question.id).first
      if !answer.correct
        wrong_answers += 1
      end
    end
    if wrong_answers > 2
      return false
    else
      return true
    end
  end

  def self.complete(user, quiz)
   user.quizzes << quiz 
  end
end
