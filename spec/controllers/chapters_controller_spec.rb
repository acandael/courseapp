require 'spec_helper'

describe ChaptersController do
  describe "GET #show" do
    it "set @chapter" do
      course = Fabricate(:course)
      chapter = Fabricate(:chapter, course_id: course.id)
      get :show, id: chapter.id, course_id: course.id
      expect(assigns(:chapter)).to eq(chapter)
    end

    it "renders the show template" do
      course = Fabricate(:course)
      chapter = Fabricate(:chapter, course_id: course.id)
      get :show, id: chapter.id, course_id: course.id
      expect(response).to render_template :show
    end
  end
end
