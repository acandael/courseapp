class AnswersController < ApplicationController

  def update
    @question = Question.find(params[:question_id])
    quiz = Quiz.find(@question.quiz_id)
    @answer = Answer.find(params[:id])
    redirect_to quiz_question_path(quiz.id, @question.id)
  end

end
  

  
