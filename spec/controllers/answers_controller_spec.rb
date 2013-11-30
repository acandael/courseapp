require 'spec_helper'

describe AnswersController do
  describe "PUT #update" do
    context "with valid user" do
      before do
        @quiz = Fabricate(:quiz)
        @question = Fabricate(:question, quiz_id: @quiz.id)
        @answer = Fabricate(:answer, question_id: @question.id)
      end
      it_behaves_like "requires sign in" do
        let(:action) { put :update, question_id: @question.id, id: @answer.id }
      end
      it "stores the answer of the user" do
        user = Fabricate(:user)
        set_current_user user 
        put :update, question_id: @question.id, id: @answer.id
        expect(user.answers.first).to eq(@answer)
      end

      it "redirects to questions#show" do
        set_current_user
        put :update, question_id: @question.id, id: @answer.id
        expect(response).to redirect_to quiz_question_path(@quiz.id, @question.id)
      end
    end
  end
end
