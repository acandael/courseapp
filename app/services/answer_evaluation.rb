class AnswerEvaluation
  def initialize

  end
  def evaluate(quiz_id)
    quiz = Quiz.find(quiz_id)
    wrong_answers = 0
    quiz.questions.each do |question|
      answer = current_user.answers.where("question_id = ?", question.id)
      if answer.correct == false
        wrong_answers += 1
      end
    end
    if wrong_answers > 2
      return false
    else
      return true
    end
  end
end
