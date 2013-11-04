require 'spec_helper'

describe Admin::QuizzesController do
  describe "GET #show" do
    before do
      @chapter = Fabricate(:chapter)
      @quiz = Fabricate(:quiz, chapter_id: @chapter.id)
    end
    it_behaves_like "requires sign in" do
      let(:action) { get :show, chapter_id: @chapter.id, id: @quiz.id }
    end
  end
  describe "GET #new" do
    before do
      @chapter = Fabricate(:chapter)
    end
    it_behaves_like "requires sign in" do
      let(:action) { get :new, chapter_id: @chapter.id }
    end
    it_behaves_like "requires admin" do
      let(:action) { get :new, chapter_id: @chapter.id }
    end
    context "success path" do
      it "sets the quiz to a new quiz" do
        set_current_admin
        get :new, chapter_id: @chapter.id
        expect(assigns(:quiz)).to be_instance_of(Quiz)
        expect(assigns(:quiz)).to be_new_record
      end
      it "assigns a chapter to the quiz" do
        set_current_admin
        get :new, chapter_id: @chapter.id
        expect(assigns(:quiz).chapter_id).to eq(@chapter.id) 
      end

      it "sets the flash error message for regular user" do
        set_current_user
        get :new, chapter_id: @chapter.id
        expect(flash[:error]).to be_present
      end
    end
    context "chapter already has a quiz" do
      it "sets error message" do
        set_current_admin
        quiz2 = Fabricate(:quiz, chapter_id: @chapter.id)
        get :new, chapter_id: @chapter.id
        expect(flash[:error]).to be_present 
      end
      it "redirects to the chapter show template" do
        set_current_admin
        quiz2 = Fabricate(:quiz, chapter_id: @chapter.id)
        get :new, chapter_id: @chapter.id
        expect(response).to redirect_to admin_chapter_path(@chapter.id)
      end
    end
  end

  describe "POST #create" do
    before do
      @chapter = Fabricate(:chapter)
    end
    it_behaves_like "requires sign in" do
      let(:action) { post :create, chapter_id: @chapter.id }
    end
    it_behaves_like "requires admin" do
      let(:action) { post :create, chapter_id: @chapter.id }
    end

    context "with valid input" do
      it "redirects to the chapter show page" do
        set_current_admin
        post :create, chapter_id: @chapter.id, quiz: { title: "the safe workplace quiz", succcess_message: "congratiulations", chapter_id: @chapter.id }
        expect(response).to redirect_to admin_chapter_path(@chapter.id)
      end
      it "creates a new quiz" do
        set_current_admin
        post :create, chapter_id: @chapter.id, quiz: { title: "the safe workplace quiz", succcess_message: "congratiulations", chapter_id: @chapter.id }
        expect(Quiz.count).to eq(1) 
      end
      it "set the flash success message" do
        set_current_admin
        post :create, chapter_id: @chapter.id, quiz: { title: "the safe workplace quiz", succcess_message: "congratiulations", chapter_id: @chapter.id }
        expect(flash[:success]).to be_present 

      end
    end
    context "with invalid input" do
      it "does not creat a new quiz" do
        set_current_admin
        post :create, chapter_id: @chapter.id, quiz: { title: "", succcess_message: "congratiulations", chapter_id: @chapter.id }
        expect(Quiz.count).to eq(0) 

      end
      it "renders the :new template" do
        set_current_admin
        post :create, chapter_id: @chapter.id, quiz: { title: "", succcess_message: "congratiulations", chapter_id: @chapter.id }
        expect(response).to render_template :new 
      end
      it "sets the @quiz variable" do
        set_current_admin
        post :create, chapter_id: @chapter.id, quiz: { title: "", succcess_message: "congratiulations", chapter_id: @chapter.id }
        expect(assigns(:quiz)).to be_present 
      end
      it "sets the flash error message" do
        set_current_admin
        post :create, chapter_id: @chapter.id, quiz: { title: "", succcess_message: "congratiulations", chapter_id: @chapter.id }
        expect(flash[:error]).to be_present 
      end
    end
  end
end
