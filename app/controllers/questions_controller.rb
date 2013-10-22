class QuestionsController < ApplicationController
  def show
      if Question.is_last?(params[:id])
        question = Question.find(params[:id])
        redirect_to quiz_complete_path(id: question.quiz_id) 
      else
        @question = Question.subsequent_question(params[:id])
        redirect_to show_question_path(id: @question.quiz_id, question_id: @question.id)
    end
  end
end
