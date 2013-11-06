class Admin::AnswersController < ApplicationController
  before_filter :require_user
  before_filter :require_admin
  
  def new
    @answer = Answer.new
    @question = Question.find(params[:question_id])
    @quiz = Quiz.find(@question.quiz_id)
    @chapter = Chapter.find(@quiz.chapter_id)
    @answer.question_id = @question.id
  end

  private

  
  def require_admin
    if !current_user.admin?
      flash[:error] = "You are not authorized to do that."
      redirect_to home_path
    end
  end
end
