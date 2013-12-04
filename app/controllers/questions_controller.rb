class QuestionsController < ApplicationController
  before_filter :require_user
  def show
    @quiz = Quiz.find(params[:quiz_id])
    @question = Question.next(params[:id])
    if @question != nil
      redirect_to quiz_path(@quiz.id, question_id: @question.id)
    else
      evaluation = Evaluation.new(@quiz, current_user)
      if evaluation.pass? 
        redirect_to quiz_complete_path(@quiz.id)
      else
        redirect_to quiz_fail_path(@quiz.id)
      end
    end
  end

  private
end
