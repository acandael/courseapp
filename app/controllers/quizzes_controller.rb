class QuizzesController < ApplicationController
  before_filter :require_user
  def show
    @quiz = Quiz.find(params[:id])
    chapter = Chapter.find(@quiz.chapter_id)
    @course = Course.find(chapter.course_id)
    if params[:question_id].present?
      @question = Question.find(params[:question_id])
    else
      @question = @quiz.questions.sort.first  
    end

  end

  def complete
    @quiz = Quiz.find(params[:id])
    @chapter = Chapter.find(@quiz.chapter_id)
    @course = Course.find(@chapter.course_id)
  end

  def fail
    @quiz = Quiz.find(params[:id])
    @chapter = Chapter.find(@quiz.chapter_id)
    @course = Course.find(@chapter.course_id)
  end

  def retake
    @quiz = Quiz.find(params[:id])
    remove_answers
    redirect_to quiz_path(@quiz.id)
  end

  private

  def remove_answers
    @quiz.questions.each do |question|
        answer = current_user.answers.where("question_id = ?", question.id).first
        current_user.answers.delete(answer)
    end
  end
end
