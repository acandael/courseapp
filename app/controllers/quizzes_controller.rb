class QuizzesController < ApplicationController
  def show
    @quiz = Quiz.find(params[:id])
    @chapter = Chapter.find(@quiz.chapter_id)
    @course = Course.find(@chapter.course_id)
    if params[:question_id].present?
      @question = Question.find(params[:question_id])
      @answer = @question.answers.first
    else
      @question = @quiz.questions.first  
      @answer = @question.answers.first
    end

  end

  def complete
    @quiz = Quiz.find(params[:id])
    @chapter = Chapter.find(@quiz.chapter_id)
    @course = Course.find(@chapter.course_id)
  end
end
