require 'spec_helper'

describe ChaptersController do
  describe "GET #show" do
    it "set @chapter" do
      course = Fabricate(:course)
      chapter = Fabricate(:chapter, course_id: course.id)
      get :show, id: chapter.id, course_id: course.id
      expect(assigns(:chapter)).to eq(chapter)
    end

    it "sets @video" do
      course = Fabricate(:course)
      chapter = Fabricate(:chapter, course_id: course.id)
      video = Fabricate(:video, chapter_id: chapter.id)
      get :show, id: chapter.id, course_id: course.id, video_id: video.id
      expect(assigns(:video)).to eq(video)
    end

    it "renders the show template" do
      course = Fabricate(:course)
      chapter = Fabricate(:chapter, course_id: course.id)
      get :show, id: chapter.id, course_id: course.id
      expect(response).to render_template :show
    end

    it "starts the next chapter" do
      course = Fabricate(:course)
      chapter1 = Fabricate(:chapter, course_id: course.id)
      chapter2 = Fabricate(:chapter, course_id: course.id)
      get :show, id: chapter1.id, next: true
      expect(assigns(:chapter)).to eq(chapter2) 
    end
  end
end
