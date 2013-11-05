require 'spec_helper'

describe Admin::QuestionsController do
  describe "GET #show" do
    before do
      @chapter = Fabricate(:chapter)
      @quiz = Fabricate(:quiz, chapter_id: @chapter.id)
      @question = Fabricate(:question, quiz_id: @quiz.id)
    end
    it_behaves_like "requires sign in" do
      let(:action) { get :show, quiz_id: @quiz.id, id: @question.id }
    end
    it_behaves_like "requires admin" do
      let(:action) { get :show, quiz_id: @quiz.id, id: @question.id }
    end
    context "with valid user" do
      it "renders the :show template" do
        set_current_admin
        get :show, quiz_id: @quiz.id, id: @question.id
        expect(response).to render_template :show
      end
      it "returns a question" do
        set_current_admin
        get :show, quiz_id: @quiz.id, id: @question.id
        expect(assigns(:question)).to be_present 
      end
      it "returns a question for the quiz" do
        set_current_admin
        get :show, quiz_id: @quiz.id, id: @question.id
        expect(assigns(:question).quiz_id).to eq(@question.quiz_id)
      end
    end
    context "with invalid user" do
      it "redirects to the sign in page" do
        get :show, quiz_id: @quiz.id, id: @question.id
        expect(response).to redirect_to sign_in_path
      end
    end
  end
  describe "GET #new" do
    before do
      @chapter = Fabricate(:chapter)
      @quiz = Fabricate(:quiz, chapter_id: @chapter.id)
    end
    it_behaves_like "requires sign in" do
      let(:action) { get :new, quiz_id: @quiz.id }
    end
    it_behaves_like "requires admin" do
      let(:action) { get :new, quiz_id: @quiz.id }
    end

    it "sets the question to a new question" do
      set_current_admin
      get :new, quiz_id: @quiz.id
      expect(assigns(:question)).to be_instance_of(Question)
      expect(assigns(:question)).to be_new_record
    end
    it "assigns a quiz to the question" do
      set_current_admin
      get :new, quiz_id: @quiz.id
      expect(assigns(:question).quiz_id).to eq(@quiz.id) 
    end
    it "set the flash error message for regular user" do
      set_current_user
      get :new, quiz_id: @quiz.id
      expect(flash[:error]).to be_present
    end
  end

  describe "POST #create" do
    before do
      @quiz = Fabricate(:quiz)
    end
    it_behaves_like "requires sign in" do
      let(:action) { post :create, quiz_id: @quiz.id }
    end
    it_behaves_like "requires admin" do
      let(:action) { post :create, quiz_id: @quiz.id }
    end

    context "with valid input" do
      it "redirects to the quiz show page" do
        set_current_admin
        post :create, quiz_id: @quiz.id, question: { title: "the safe workplace quiz", quiz_id: @quiz.id }
        expect(response).to redirect_to admin_quiz_path(@quiz.id)
      end
      it "creates a new question" do
        set_current_admin
        post :create, quiz_id: @quiz.id, question: { title: "the safe workplace quiz", quiz_id: @quiz.id }
        expect(Question.count).to eq(1) 
      end
      it "sets the flash success message" do
        set_current_admin
        post :create, quiz_id: @quiz.id, question: { title: "the safe workplace quiz", quiz_id: @quiz.id }
        expect(flash[:success]).to be_present 
      end
    end
    context "with invalid input" do
      it "renders the :new template" do
        set_current_admin
        post :create, quiz_id: @quiz.id, question: { title: "", quiz_id: @quiz.id }
        expect(response).to render_template :new
      end
      it "does not create a new question" do
        set_current_admin
        post :create, quiz_id: @quiz.id, question: { title: "", quiz_id: @quiz.id }
        expect(Question.count).to eq(0)
      end
      it "sets the @question variable" do
        set_current_admin
        post :create, quiz_id: @quiz.id, question: { title: "", quiz_id: @quiz.id }
        expect(assigns(:question)).to be_present 
      end
      it "sets the flash error message" do
        set_current_admin
        post :create, quiz_id: @quiz.id, question: { title: "", quiz_id: @quiz.id }
        expect(flash[:error]).to be_present
      end
    end
  end

  describe "PUT #update" do
    before do
      @quiz = Fabricate(:quiz)
      @question = Fabricate(:question, quiz_id: @quiz.id)
    end
    it_behaves_like "requires sign in" do
      let(:action) { put :update, quiz_id: @quiz.id, id: @question.id }
    end
    it_behaves_like "requires admin" do
      let(:action) { put :update, quiz_id: @quiz.id, id: @question.id }
    end
    context "with valid input" do
      it "redirects to the question show page" do
        set_current_admin
        put :update, quiz_id: @quiz.id, id: @question.id, question: { title: "new title" }
        expect(response).to redirect_to admin_quiz_question_path(@question.quiz_id, @question.id)
      end
      it "updates the question" do
        set_current_admin
        put :update, quiz_id: @quiz.id, id: @question.id, question: { title: "new title" }
        expect(assigns(:question).title).to eq("new title")
      end
      it "sets the flash success message" do
        set_current_admin
        put :update, quiz_id: @quiz.id, id: @question.id, question: { title: "new title" }
        expect(flash[:success]).to be_present
      end
    end
    context "with invalid input" do
      it "renders the :edit template" do
        set_current_admin
        put :update, quiz_id: @quiz.id, id: @question.id, question: { title: "" }
        expect(response).to render_template :edit
      end
      it "does not update the video" do
        set_current_admin
        put :update, quiz_id: @quiz.id, id: @question.id, question: { title: "" }
        @question.reload
        expect(@question.title).not_to eq("")
      end
      it "sets a flash error message" do
        set_current_admin
        put :update, quiz_id: @quiz.id, id: @question.id, question: { title: "" }
        expect(flash[:error]).to be_present
      end
      it "sets the @question" do
        set_current_admin
        put :update, quiz_id: @quiz.id, id: @question.id, question: { title: "" }
        expect(assigns(:question)).to be_present
      end
    end
  end
  describe "DELETE #destroy" do
    before do
      @quiz = Fabricate(:quiz)
      @question = Fabricate(:question, quiz_id: @quiz.id)
    end
    it_behaves_like "requires sign in" do
      let(:action) { delete :destroy, quiz_id: @quiz.id, id: @question.id }
    end
    it_behaves_like "requires admin" do
      let(:action) { delete :destroy, quiz_id: @quiz.id, id: @question.id }
    end
    it "redirects to the quiz show page" do
      set_current_admin
      delete :destroy, quiz_id: @quiz.id, id: @question.id
      expect(response).to redirect_to admin_quiz_path(@quiz.id)
    end
    it "deletes the question" do
      set_current_admin
      delete :destroy, quiz_id: @quiz.id, id: @question.id
      expect(@quiz.questions.count).to eq(0)
    end
    it "sets the flash success message" do
      set_current_admin
      delete :destroy, quiz_id: @quiz.id, id: @question.id
      expect(flash[:success]).to be_present
    end
  end
end
