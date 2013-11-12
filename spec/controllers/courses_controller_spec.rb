require 'spec_helper'

describe CoursesController do
  describe "GET #show" do
    before do
      @course = Fabricate(:course)
    end
    context "with valid user" do
      it "set @course" do
        set_current_user
        get :show, id: @course.id
        expect(assigns(:course)).to be_present 
      end
    end
    context "with invalid user" do
        it "redirects to the sign in page" do
          get :show, id: @course.id
          expect(response).to redirect_to sign_in_path
        end
    end
  end
end
