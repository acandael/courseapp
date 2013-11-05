class Admin::QuestionsController < ApplicationController
  before_filter :require_user
  before_filter :require_admin

  def new
    @question = Question.new
    @quiz = Quiz.find(params[:quiz_id])
    @question.quiz_id = @quiz.id
    @chapter = Chapter.find(@quiz.chapter_id)
  end

  def show
    @question = Question.find(params[:id]) 
    @quiz = Quiz.find(params[:quiz_id])
    @chapter = Chapter.find(@quiz.chapter_id)
  end

  def create
    @question = Question.create(question_params(params[:question]))
    @question.quiz_id = params[:quiz_id]
    if @question.save
      flash[:success] = "You successfully created the question: '#{@question.title}'."
      redirect_to admin_quiz_path(params[:quiz_id])
    else
      flash[:error] = "The question was not created. Please check the error messages."
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

  def question_params(param)
    params.require(:question).permit(:title, :quiz_id)
  end
end
