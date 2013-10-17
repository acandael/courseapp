require 'spec_helper'

describe CoursesController do
  describe "GET #show" do
    it "set @course" do
      course = Fabricate(:course)
      get :show, id: course.id
      expect(assigns(:course)).to eq(course)
    end
  end
end
