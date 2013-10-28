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

  describe "PUT#update" do
    before do
        @course = Fabricate(:course)
    end
    it_behaves_like "requires sign in" do
      let(:action) { post :update, id: @course.id }
    end
    
    it_behaves_like "requires admin" do
      let(:action) { post :update, id: @course.id }
    end

    context "with valid input" do
      it "updates an existing record" do
        set_current_admin
        put :update, id: @course.id, course: { id: @course.id, title: "new title", description: @course.description } 
        @course.reload
        expect(Course.find(@course.id).title).to eq(@course.title)
      end

      it "sets a flash success message" do
        set_current_admin
        put :update, id: @course.id, course: { id: @course.id, title: "new title", description: @course.description } 

        expect(flash[:success]).to be_present
      end
      it "redirects to the courses index page" do
        set_current_admin
        put :update, id: @course.id, course: { id: @course.id, title: "new title", description: @course.description } 

        expect(response).to redirect_to admin_courses_path 
      end
    end

    context "with invalid input " do
      it "does not update an existing record" do
        set_current_admin
        put :update, id: @course.id, course: { id: @course.id, title: "new title", description: nil} 
        @course.reload
        expect(Course.find(@course.id).description).not_to eq("") 
      end
      it "renders the :edit template" do
        set_current_admin
        put :update, id: @course.id, course: { id: @course.id, title: "new title", description: nil }
        expect(response).to render_template :edit 
      end
      it "set a flash error message" do
        set_current_admin
        put :update, id: @course.id, course: { id: @course.id, title: "new title", description: nil } 

        expect(flash[:error]).to be_present
      end
    end
  end
  
  describe "DELETE #destroy" do
    before do
        @course = Fabricate(:course)
    end
    it_behaves_like "requires sign in" do
      let(:action) { delete :destroy, id: @course.id }
    end
    
    it_behaves_like "requires admin" do
      let(:action) { delete :destroy, id: @course.id }
    end

    it "redirects to the admin courses index page" do
      set_current_admin
      delete :destroy, id: @course.id
      expect(response).to redirect_to admin_course_path
    end
    it "deletes the course" do
      set_current_admin
      delete :destroy, id: @course.id
      expect(Course.count).to eq(0)
    end
    it "set the flash message" do
      set_current_admin
      delete :destroy, id: @course.id
      expect(flash[:success]).to be_present 
    end
  end
end
