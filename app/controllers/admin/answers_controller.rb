class Admin::AnswersController < ApplicationController
  before_filter :require_user
  before_filter :require_admin

  def show
    @answer = Answer.find(params[:id])
    @question = Question.find(params[:question_id])
    @quiz = Quiz.find(@question.quiz_id)
  end
  
  def new
    @answer = Answer.new
    @question = Question.find(params[:question_id])
    @quiz = Quiz.find(@question.quiz_id)
    @answer.question_id = @question.id
  end

  def create
    @answer = Answer.create(answer_params(params[:answer]))
    @answer.question_id = params[:question_id]
    question = Question.find(@answer.question_id)
    quiz = Quiz.find(question.quiz_id)
    if @answer.save
      flash[:success] = "You successfully added the answer: '#{@answer.title}'."
      redirect_to admin_quiz_question_path(quiz.id, question.id)
    else
      flash[:error] = "The answer is not created. Please check the error messages."
      render :new
    end
  end

  def edit
    @answer = Answer.find(params[:id])
    @question = Question.find(params[:question_id])
    @quiz = Quiz.find(@question.quiz_id)
  end

  def update
    @answer = Answer.find(params[:id])
    if @answer.update_attributes(answer_params(params[:answer]))
      flash[:success] = "You successfully updated the answer: '#{@answer.title}'."
      redirect_to admin_question_answer_path(params[:question_id], params[:id])
    else
      flash[:error] = "The answer was not updated. Please check the error messages."
      render :edit
    end
  end

  private

  
  def require_admin
    if !current_user.admin?
      flash[:error] = "You are not authorized to do that."
      redirect_to home_path
    end
  end

  def answer_params(param)
    params.require(:answer).permit(:title, :is_correct, :question_id)
  end
end
