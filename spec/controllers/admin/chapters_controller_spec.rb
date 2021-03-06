require 'spec_helper'

describe Admin::ChaptersController do

  describe "GET #index" do
    before do
      @course = Fabricate(:course)
    end
    it_behaves_like "requires sign in" do
      let(:action) { get :index, course_id: @course.id }
    end
    it_behaves_like "requires admin" do
      let(:action) { get :index, course_id: @course.id}
    end
    
    it "sets the course" do
      set_current_admin
      get :index, course_id: @course.id
      expect(assigns(:course)).to eq(@course)
    end
    it "set chapters" do
      set_current_admin
      chapter1 = Fabricate(:chapter, course_id: @course.id)
      chapter2 = Fabricate(:chapter, course_id: @course.id)
      get :index, course_id: @course.id
      expect(assigns(:chapters)).to be_present 
    end
  end

  describe "GET #show" do
    before do
      @course = Fabricate(:course)
      @chapter = Fabricate(:chapter, course_id: @course.id)
    end
    it_behaves_like "requires sign in" do
      let(:action) { get :show, course_id: @course.id, id: @chapter.id }
    end
    it_behaves_like "requires admin" do
      let(:action) { get :show, course_id: @course.id, id: @chapter.id }
    end
    context "with valid user" do
      it "renders the :show template" do
        set_current_admin
        get :show, course_id: @course.id, id: @chapter.id
        expect(response).to render_template :show
      end
      it "returns a chapter" do
        set_current_admin
        get :show, course_id: @course.id, id: @chapter.id
        expect(assigns(:chapter)).to be_present 
      end
    end

    context "with invalid user" do
      it "redirects to the sign in page" do
        get :show, course_id: @course.id, id: @chapter.id
        expect(response).to redirect_to sign_in_path 
      end
    end
  end

  describe "GET #new" do
    before do
      @course = Fabricate(:course)
    end
    it_behaves_like "requires sign in" do
      let(:action) { get :new, course_id: @course.id }
    end
    it_behaves_like "requires admin" do
      let(:action) { get :new, course_id: @course.id}
    end
    it "sets the chapter to a new chapter" do
      set_current_admin
      get :new, course_id: @course.id
      expect(assigns(:chapter)).to be_instance_of(Chapter)
      expect(assigns(:chapter)).to be_new_record
    end

    it "sets the flash error message for regular user" do
      set_current_user
      get :new, course_id: @course.id
      expect(flash[:alert]).to be_present
    end
  end
  describe "POST #create" do
    before do
      @course = Fabricate(:course)
    end
    it_behaves_like "requires sign in" do
      let(:action) { post :create, course_id: @course.id }
    end
    it_behaves_like "requires admin" do
      let(:action) { post :create, course_id: @course.id }
    end
    context "with valid input" do
      it "redirects to the course show page" do
        set_current_admin
        post :create, chapter: { title: "the safe workplace", description: "what you should know about a safe workplace", course_id: @course.id, tagline: "congratulations, you earned the safe workplace badge", badge_image: "safe_workplace.jpg" }, course_id: @course.id
        expect(response).to redirect_to admin_course_path(@course.id)
      end
      it "creates a new chapter" do
        set_current_admin
        course = Fabricate(:course)
        post :create, chapter: { title: "the safe workplace", description: "what you should know about a safe workplace", course_id: course.id, tagline: "congratulations, you earned the safe workplace badge", badge_image: "safe_workplace.jpg" }, course_id: @course.id
        expect(Chapter.count).to eq(1) 
      end
      it "sets the flash success message" do
        set_current_admin
        course = Fabricate(:course)
        post :create, chapter: { title: "the safe workplace", description: "what you should know about a safe workplace", course_id: course.id, tagline: "congratulations, you earned the safe workplace badge", badge_image: "safe_workplace.jpg" }, course_id: @course.id
        expect(flash[:success]).to be_present 
      end
    end
    context "with invalid input" do
      it "does not create a new chapter" do
        set_current_admin
        course = Fabricate(:course)
        post :create, chapter: { description: "what you should know about a safe workplace", course_id: course.id, tagline: "congratulations, you earned the safe workplace badge", badge_image: "safe_workplace.jpg" }, course_id: @course.id
        expect(Chapter.count).to eq(0) 
      end
      it "renders the :new template" do
        set_current_admin
        course = Fabricate(:course)
        post :create, chapter: { description: "what you should know about a safe workplace", course_id: course.id, tagline: "congratulations, you earned the safe workplace badge", badge_image: "safe_workplace.jpg" }, course_id: @course.id
        expect(response).to render_template :new 
      end
      it "sets the @chapter variable" do
        set_current_admin
        course = Fabricate(:course)
        post :create, chapter: { description: "what you should know about a safe workplace", course_id: course.id, tagline: "congratulations, you earned the safe workplace badge", badge_image: "safe_workplace.jpg" }, course_id: @course.id
        expect(assigns(:chapter)).to be_present 
      end
      it "sets the flash error message" do
        set_current_admin
        course = Fabricate(:course)
        post :create, chapter: { description: "what you should know about a safe workplace", course_id: course.id, tagline: "congratulations, you earned the safe workplace badge", badge_image: "safe_workplace.jpg" }, course_id: @course.id
        expect(flash[:alert]).to be_present 
      end
    end
  end

  describe "PUT #update" do
    before do
      @course = Fabricate(:course)
      @chapter = Fabricate(:chapter, course_id: @course.id)
    end
    it_behaves_like "requires sign in" do
      let(:action) { post :update, course_id: @course.id, id: @chapter.id  }
    end
    it_behaves_like "requires admin" do
      let(:action) { post :update, course_id: @course.id, id: @chapter.id  }
    end

    context "with valid input" do
      it "redirects to the chapter show page" do
        set_current_admin
        put :update, course_id: @course.id, id: @chapter.id, chapter: { title: "new title", description: @chapter.description, course_id: @chapter.course_id, tagline: @chapter.tagline, badge_image: @chapter.badge_image } 
        expect(response).to redirect_to admin_course_chapter_path(@chapter.course_id, @chapter.id)
      end
      it "updates the chapter" do
        set_current_admin
        put :update, course_id: @course.id, id: @chapter.id, chapter: { title: "new title", description: @chapter.description, course_id: @chapter.course_id, tagline: @chapter.tagline, badge_image: @chapter.badge_image } 
        @chapter.reload
        expect(@chapter.title).to eq("new title")
      end
      it "sets the flash success message" do
        set_current_admin
        put :update, course_id: @course.id, id: @chapter.id, chapter: { title: "new title", description: @chapter.description, course_id: @chapter.course_id, tagline: @chapter.tagline, badge_image: @chapter.badge_image } 
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid input" do
      it "does not update the chapter" do
        set_current_admin
        put :update, course_id: @course.id, id: @chapter.id, chapter: { title: "new title", description: "", course_id: @chapter.course_id, tagline: @chapter.tagline, badge_image: @chapter.badge_image } 
        @chapter.reload
        expect(Chapter.find(@chapter.id).description).not_to eq("")
      end
      it "renders the :edit template" do
        set_current_admin
        put :update, course_id: @course.id, id: @chapter.id, chapter: { title: "new title", description: "", course_id: @chapter.course_id, tagline: @chapter.tagline, badge_image: @chapter.badge_image } 
        expect(response).to render_template :edit 
      end
      it "sets a flash error message" do
        set_current_admin
        put :update, course_id: @course.id, id: @chapter.id, chapter: { title: "new title", description: "", course_id: @chapter.course_id, tagline: @chapter.tagline, badge_image: @chapter.badge_image } 
        expect(flash[:alert]).to be_present 
      end
      it "sets the @chapter" do
        set_current_admin
        put :update, course_id: @course.id, id: @chapter.id, chapter: { title: "new title", description: "", course_id: @chapter.course_id, tagline: @chapter.tagline, badge_image: @chapter.badge_image } 
        expect(assigns(:chapter)).to be_present 
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      @course = Fabricate(:course)
      @chapter = Fabricate(:chapter, course_id: @course.id)
    end
    it_behaves_like "requires sign in" do
      let(:action) { delete :destroy, course_id: @course.id, id: @chapter.id  }
    end
    it_behaves_like "requires admin" do
      let(:action) { post :update, course_id: @course.id, id: @chapter.id  }
    end
    context "with valid user" do
      it "redirects to the course show page" do
        set_current_admin
        delete :destroy, course_id: @chapter.course_id, id: @chapter.id
        expect(response).to redirect_to admin_course_path(@course.id)
      end
      it "deletes the chapter" do
        set_current_admin
        delete :destroy, course_id: @chapter.course_id, id: @chapter.id
        expect(@course.chapters.count).to eq(0)
      end
      it "sets the flash success message" do
        set_current_admin
        delete :destroy, course_id: @chapter.course_id, id: @chapter.id
        expect(flash[:success]).to be_present 
      end
    end
  end
end
