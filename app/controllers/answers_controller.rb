class AnswersController < ApplicationController
  def check_answer
    @answer = Answer.find(params[:id])
    question = Question.find(@answer.question_id)
    if Question.is_last?(question.id)
      redirect_to quiz_complete_path(id: question.quiz_id)
    else
      next_question = Question.subsequent_question(question.id)
      redirect_to show_question_path(id: question.quiz_id, question_id: next_question.id)  
    end
  end
end
