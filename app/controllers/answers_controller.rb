class AnswersController < ApplicationController
  before_filter :require_user
  def update
    @answer = Answer.find(params[:id])
    @question = Question.find(@answer.question_id)
    @quiz = Quiz.find(@question.quiz.id)
    current_user.answers << @answer
  end
end
