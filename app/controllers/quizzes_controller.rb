class QuizzesController < ApplicationController
  before_filter :require_user
  def show
    @quiz = Quiz.find(params[:id])
    chapter = Chapter.find(@quiz.chapter_id)
    @course = Course.find(chapter.course_id)
    remove_answers(@quiz.id) #remove answers from previous quiz attempt
    if params[:question_id].present?
      @question = Question.find(params[:question_id])
    else
      @question = @quiz.questions.first  
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
    remove_answers(@quiz.id)
    redirect_to quiz_path(@quiz.id)
  end

  private

  def remove_answers(quiz_id)
    @quiz.questions.each do |question|
      if current_user.answers.include?(question.id)
        answer = current_user.answers.where("question_id = ?", question.id).first != nil
        current_user.answers.delete(answer)
      end
    end
  end
end
