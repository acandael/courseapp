require 'spec_helper'

describe Admin::AnswersController do
  describe "GET #show" do
    before do
      @quiz = Fabricate(:quiz)
      @question = Fabricate(:question, quiz_id: @quiz.id)
      @answer = Fabricate(:answer, question_id: @question.id)
    end
    it_behaves_like "requires sign in" do
      let(:action) { get :show, question_id: @question.id, id: @answer.id }
    end
  end
  describe "GET #new" do
    before do
      @quiz = Fabricate(:quiz)
      @question = Fabricate(:question, quiz_id: @quiz.id)
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

  describe "POST #create" do
    before do
      @quiz = Fabricate(:quiz)
      @question = Fabricate(:question, quiz_id: @quiz.id)
    end
    it_behaves_like "requires sign in" do
      let(:action) { post :create, question_id: @question.id }
    end
    it_behaves_like "requires admin" do
      let(:action) { post :create, question_id: @question.id }
    end

    context "with valid input" do
      it "redirects to the question show page" do
        set_current_admin
        post :create, question_id: @question.id, answer: { title: "David Heinemeier Hanson", is_correct: true }
        expect(response).to redirect_to admin_question_path(@question.id)
      end
      it "creates a new answer" do
        set_current_admin
        post :create, question_id: @question.id, answer: { title: "David Heinemeier Hanson", is_correct: true }
        expect(Answer.count).to eq(1)
      end
      it "sets the flash success message" do
        set_current_admin
        post :create, question_id: @question.id, answer: { title: "David Heinemeier Hanson", is_correct: true }
        expect(flash[:success]).to be_present
      end
      it "set the property is_correct" do
        set_current_admin
        post :create, question_id: @question.id, answer: { title: "David Heinemeier Hanson", is_correct: true }
        expect(assigns(:answer).is_correct?).to be_true
      end
    end
    context "with invalid input" do
      it "renders the :new template" do
        set_current_admin
        post :create, question_id: @question.id, answer: { title: "", is_correct: true }
        expect(response).to render_template :new
      end
      it "does not create a new answer" do
        set_current_admin
        post :create, question_id: @question.id, answer: { title: "", is_correct: true }
        expect(Answer.count).to eq(0)
      end
      it "sets the @answer variable" do
        set_current_admin
        post :create, question_id: @question.id, answer: { title: "", is_correct: true} 
        expect(assigns(:answer)).to be_present

      end
      it "sets the flash error message" do
        set_current_admin
        post :create, question_id: @question.id, answer: { title: "", is_correct: true} 
        expect(flash[:error]).to be_present
      end
    end
  end
end
