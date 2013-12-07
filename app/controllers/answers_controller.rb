class AnswersController < ApplicationController
  before_filter :require_user
  def update
    answer = Answer.find(params[:id])
    question = Question.find(answer.question_id)
    current_user.answers << answer
    redirect_to quiz_question_path(quiz_id: question.quiz_id, id: question.id) 
  end
end
