class AnswerEvaluation
  def evaluate(quiz_id)
    wrong_answers = 0
    quiz = Quiz.find(quiz_id)
    quiz.questions.each do |question|
      answer = current_user.answers.where(question_id: question.id)
      if answer == false
        wrong_answer += 1
      end
    end
    if wrong_answers > 2
      return false
    else
      return true
    end
  end
end
