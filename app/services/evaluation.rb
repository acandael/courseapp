class Evaluation
  def initialize(quiz, user)
    @quiz = quiz
    @user = user
  end

  def pass?
    wrong_answers = 0
    @quiz.questions.each do |question|
      answer = @user.answers.where("question_id = ?", question.id).first
      if !answer.correct
        wrong_answers += 1
      end
    end
    if wrong_answers > 2
      return false
    else
      complete
      return true
    end
  end

  def complete
   @user.quizzes << @quiz 
  end
end
