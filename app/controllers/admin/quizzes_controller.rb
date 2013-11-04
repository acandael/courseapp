class Admin::QuizzesController < ApplicationController
  before_filter :require_user
  before_filter :require_admin

  def new
    @chapter = Chapter.find(params[:chapter_id])
    if @chapter.quiz.present?
      flash[:error] = "Chapter #{@chapter.title} already has a quiz"
      redirect_to admin_chapter_path(@chapter.id)
    else
      @quiz = Quiz.new
      @quiz.chapter_id = @chapter.id
    end
  end
 
  def create
    @quiz = Quiz.create(quiz_params(params[:quiz]))
    if @quiz.save 
      flash[:success] = "You successfully created a new quiz, #{ @quiz.title }."
      redirect_to admin_chapter_path(params[:chapter_id])
    else
      flash[:error] = "The quiz was not created. Please check the error messages."
      render :new
    end
  end

  private


  def require_admin
    if !current_user.admin?
      flash[:error] = "You are not authorized to do that."
      redirect_to home_path
    end
  end

  def quiz_params(param)
    params.require(:quiz).permit(:title, :success_message, :chapter_id)
  end
end
