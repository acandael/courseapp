class QuestionsController < ApplicationController
  def update
    @quiz = Quiz.find(params[:quiz_id])
    @question = Question.subsequent_question(params[:id])
    redirect_to quiz_path(@quiz.id, question_id: @question.id)
  end
end
