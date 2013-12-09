require 'spec_helper'

describe VideosController do
  describe "GET #show" do
    before do
      @course = Fabricate(:course)
      @chapter = Fabricate(:chapter, course_id: @course.id)
      @video = Fabricate(:video, chapter_id: @chapter.id)
    end
    it "set @video" do
      set_current_user
      get :show, id: @video.id, chapter_id: @chapter.id
      expect(assigns(:video)).to be_present 
    end
    it "returns a video for the chapter" do
      set_current_user
      get :show, id: @video.id, chapter_id: @chapter.id
      expect(assigns(:video).chapter_id).to eq(@video.chapter_id)
    end

    it "adds the video to the current users videos collection" do
      user = Fabricate(:user)
      set_current_user user
      get :show, id: @video.id, chapter_id: @chapter.id
      expect(user.videos.first).to eq(@video)
    end

    it "does not add the video to the user when it has been watched already" do
      user = Fabricate(:user)
      set_current_user user
      user.videos << @video
      get :show, id: @video.id, chapter_id: @chapter.id
      expect(user.videos.count).to eq(1)
    end

    context "with invalid user" do
      it "redirects to the sign in page" do
        video = Fabricate(:video, chapter_id: @chapter.id)
        get :show, id: video.id, chapter_id: @chapter.id
        expect(response).to redirect_to sign_in_path
      end
    end
  end
end
