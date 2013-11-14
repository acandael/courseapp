require 'spec_helper'

describe QuestionsController do
  describe "PUT #update" do
    context "with valid user" do
      before do
        @quiz = Fabricate(:quiz)
        @question = Fabricate(:question, quiz_id: @quiz.id)
      end
      it_behaves_like "requires sign in" do
        let(:action) { put :update, quiz_id: @quiz.id, id: @question.id }
      end
      it "returns the next question" do
        set_current_user
        question1 = Fabricate(:question, quiz_id: @quiz.id)
        question2 = Fabricate(:question, quiz_id: @quiz.id)
        question3 = Fabricate(:question, quiz_id: @quiz.id)
        put :update, quiz_id: @quiz.id, id: question1.id
        expect(assigns(:question)).to eq(question2)
      end
      it "redirects to quiz_complete_path when all questions are answered" do
        set_current_user
        question1 = Fabricate(:question, quiz_id: @quiz.id)
        question2 = Fabricate(:question, quiz_id: @quiz.id)
        question3 = Fabricate(:question, quiz_id: @quiz.id)
        put :update, quiz_id: @quiz.id, id: question3.id
        expect(response).to redirect_to quiz_complete_path(@quiz.id) 
      end
    end
    context "with invalid user" do
      before do
        @quiz = Fabricate(:quiz)
        @question = Fabricate(:question, quiz_id: @quiz.id)
      end
      it_behaves_like "requires sign in" do
        let(:action) { put :update, quiz_id: @quiz.id, id: @question.id }
      end
    end
  end
end
