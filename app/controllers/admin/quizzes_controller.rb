class Admin::QuizzesController < ApplicationController
  before_filter :require_user
  before_filter :require_admin

  def show
    @quiz = Quiz.find(params[:id])
    @chapter = Chapter.find(@quiz.chapter_id)
  end

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
    @quiz.chapter_id = params[:chapter_id]
    if @quiz.save 
      flash[:success] = "You successfully created a new quiz, #{ @quiz.title }."
      redirect_to admin_chapter_path(params[:chapter_id])
    else
      flash[:error] = "The quiz was not created. Please check the error messages."
      render :new
    end
  end

  def edit
    @quiz = Quiz.find(params[:id])
    @chapter = Chapter.find(params[:chapter_id])
  end

  def update
    @quiz = Quiz.find(params[:id])
    if @quiz.update_attributes(quiz_params(params[:quiz]))
      flash[:success] = "You successfully updated quiz: '#{@quiz.title}'."
      redirect_to admin_chapter_quiz_path(params[:chapter_id], params[:id])
    else
      flash[:error] = "The quiz was not updated. Please check the error messages."
      render :edit
    end
  end

  def destroy
    quiz = Quiz.find(params[:id])
    if quiz.destroy
      flash[:success] = "You successfully deleted the quiz: '#{quiz.title}'."
      redirect_to admin_chapter_path(params[:chapter_id])  
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
    params.require(:quiz).permit(:title, :chapter_id)
  end
end
