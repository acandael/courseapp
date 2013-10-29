require 'spec_helper'

describe Admin::ChaptersController do

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
      expect(flash[:error]).to be_present
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
      it "redirects to the courses edit page" do
        set_current_admin
        post :create, chapter: { title: "the safe workplace", description: "what you should know about a safe workplace", course_id: @course.id, tagline: "congratulations, you earned the safe workplace badge", badge_image: "safe_workplace.jpg" }, course_id: @course.id
        expect(response).to redirect_to edit_admin_course_path(@course.id)
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
        expect(flash[:error]).to be_present 
      end
    end
  end
end
