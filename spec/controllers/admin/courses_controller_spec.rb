require 'spec_helper'

describe Admin::CoursesController do
  describe "GET #new" do
    it_behaves_like "requires sign in" do
      let(:action) { get :new }
    end
    it_behaves_like "requires admin" do
      let(:action) { get :new }
    end
    it "sets the course to a new course" do
      set_current_admin
      get :new
      expect(assigns(:course)).to be_instance_of(Course)
      expect(assigns(:course)).to be_new_record
    end
    it "sets the flash error message for regular user" do
      set_current_user
      get :new
      expect(flash[:error]).to be_present
    end
  end

  describe "POST #create" do
    it_behaves_like "requires sign in" do
      let(:action) { post :create }
    end
    
    it_behaves_like "requires admin" do
      let(:action) { post :create }
    end

    context "with valid input" do
      it "redirects to the courses index page" do
        set_current_admin
        post :create, course: { title: "the safe workplace", description: "what you should know about a safe workplace" }
        expect(response).to redirect_to admin_courses_path
      end
      it "creates a new course" do
        set_current_admin
        post :create, course: { title: "the safe workplace", description: "what you should know about a safe workplace" }
        expect(Course.count).to eq(1)
      end
      it "sets the flash success message" do
        set_current_admin
        post :create, course: { title: "the safe workplace", description: "what you should know about a safe workplace" }
        expect(flash[:success]).to be_present 
      end
    end
    context "with invalid input" do
      it "does not create a new course" do
        set_current_admin
        post :create, course: { description: "what you should know about a safe workplace" }
        expect(Course.count).to eq(0) 
      end
      it "renders the :new template" do
        set_current_admin
        post :create, course: { description: "what you should know about a safe workplace" }
        expect(response).to render_template :new 
      end
      it "sets the @course variable" do
        set_current_admin
        post :create, course: { description: "what you should know about a safe workplace" }
        expect(assigns(:course)).to be_present 
      end
      it "set the flash error message" do
        set_current_admin
        post :create, course: { description: "what you should know about a safe workplace" }
        expect(flash[:error]).to be_present 
      end
    end
  end
end
