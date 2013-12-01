class AnswersController < ApplicationController
  before_filter :require_user
  def update
    question = Question.find(params[:question_id])
    quiz = Quiz.find(question.quiz_id)
    answer = Answer.find(params[:id])
    current_user.answers << answer
    redirect_to quiz_question_path(quiz_id: quiz.id, id: question.id) 
  end
end
