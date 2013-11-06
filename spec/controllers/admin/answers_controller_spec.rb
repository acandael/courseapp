require 'spec_helper'

describe Admin::AnswersController do
  describe "GET #new" do
    before do
      @question = Fabricate(:question)
      @answer = Fabricate(:answer, question_id: @question.id)
    end
    it_behaves_like "requires sign in" do
      let(:action) { get :new, question_id: @question.id }
    end
    it_behaves_like "requires admin" do
      let(:action) { get :new, question_id: @question.id }
    end

    it "sets the answer to a new answer" do
      set_current_admin
      get :new, question_id: @question.id
      expect(assigns(:answer)).to be_instance_of(Answer)
      expect(assigns(:answer)).to be_new_record
    end
    it "assigns a question to the answer" do
      set_current_admin
      get :new, question_id: @question.id
      expect(assigns(:answer).question_id).to eq(@question.id)
    end
    it "sets the flash error message for regular user" do
      set_current_user
      get :new, question_id: @question.id
      expect(flash[:error]).to be_present
    end
  end
end
