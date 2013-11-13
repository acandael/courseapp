class QuestionsController < ApplicationController
  def show
      if Question.is_last?(params[:id])
        question = Question.find(params[:id])
        redirect_to quiz_complete_path(id: question.quiz_id) 
      else
        @question = Question.subsequent_question(params[:id])
        @quiz = Quiz.find(params[:quiz_id])
        @chapter = Chapter.find(@quiz.chapter_id)
        @course = Course.find(@chapter.course_id) 
    end
  end
end
