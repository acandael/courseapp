require 'spec_helper'

describe QuestionsController do
  describe "GET #show" do
    context "with valid user" do
      before do
        @quiz = Fabricate(:quiz)
        @question = Fabricate(:question, quiz_id: @quiz.id)
      end
      it_behaves_like "requires sign in" do
        let(:action) { get :show, quiz_id: @quiz.id, id: @question.id }
      end
      it "returns the next question" do
        set_current_user
        question1 = Fabricate(:question, quiz_id: @quiz.id)
        question2 = Fabricate(:question, quiz_id: @quiz.id)
        question3 = Fabricate(:question, quiz_id: @quiz.id)
        get :show, quiz_id: @quiz.id, id: question1.id
        expect(assigns(:question)).to eq(question2)
      end
      it "redirects to quiz_complete_path when the user passed the quiz" do
        user = Fabricate(:user)
        set_current_user user
        @quiz.questions = []
        question1 = Fabricate(:question, quiz_id: @quiz.id)
        question2 = Fabricate(:question, quiz_id: @quiz.id)
        question3 = Fabricate(:question, quiz_id: @quiz.id)
        answer1 = Fabricate(:answer, correct: true, question_id: question1.id)
        answer2 = Fabricate(:answer, correct: true, question_id: question2.id)
        answer3 = Fabricate(:answer, correct: true, question_id: question3.id)
        user.answers << [answer1, answer2, answer3]
        get :show, quiz_id: @quiz.id, id: question3.id
        expect(response).to redirect_to quiz_complete_path(@quiz.id) 
      end

      it "redirects to the quiz_fail_path when the user didn't pass the quiz" do
        user = Fabricate(:user)
        set_current_user user
        @quiz.questions = []
        question1 = Fabricate(:question, quiz_id: @quiz.id)
        question2 = Fabricate(:question, quiz_id: @quiz.id)
        question3 = Fabricate(:question, quiz_id: @quiz.id)
        question4 = Fabricate(:question, quiz_id: @quiz.id)
        answer1 = Fabricate(:answer, correct: false, question_id: question1.id)
        answer2 = Fabricate(:answer, correct: false, question_id: question2.id)
        answer3 = Fabricate(:answer, correct: false, question_id: question3.id)
        answer4 = Fabricate(:answer, correct: true, question_id: question4.id)
        user.answers << [answer1, answer2, answer3, answer4]
        get :show, quiz_id: @quiz.id, id: question4.id
        expect(response).to redirect_to quiz_fail_path(@quiz.id)
      end

      it "marks the quiz as complete when the user passed the quiz" do
        user = Fabricate(:user)
        set_current_user user
        @quiz.questions = []
        question1 = Fabricate(:question, quiz_id: @quiz.id)
        question2 = Fabricate(:question, quiz_id: @quiz.id)
        question3 = Fabricate(:question, quiz_id: @quiz.id)
        answer1 = Fabricate(:answer, correct: true, question_id: question1.id)
        answer2 = Fabricate(:answer, correct: true, question_id: question2.id)
        answer3 = Fabricate(:answer, correct: true, question_id: question3.id)
        user.answers << [answer1, answer2, answer3]
        get :show, quiz_id: @quiz.id, id: question3.id
        expect(user.quizzes.first).to eq(@quiz) 
      end

      
    end
    context "with invalid user" do
      before do
        @quiz = Fabricate(:quiz)
        @question = Fabricate(:question, quiz_id: @quiz.id)
      end
      it_behaves_like "requires sign in" do
        let(:action) { get :show, quiz_id: @quiz.id, id: @question.id }
      end
    end
  end
end
