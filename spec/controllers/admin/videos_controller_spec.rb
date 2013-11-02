require 'spec_helper'

describe Admin::VideosController do
  describe "GET #show" do
    before do
      @course = Fabricate(:course)
      @chapter = Fabricate(:chapter, course_id: @course.id)
      @video = Fabricate(:video, chapter_id: @chapter.id)
    end
    it_behaves_like "requires sign in" do
      let(:action) { get :show, chapter_id: @chapter.id, id: @video.id }
    end
  end
  describe "GET #new" do
    before do
      @course = Fabricate(:course)
      @chapter = Fabricate(:chapter, course_id: @course.id)
    end
    it_behaves_like "requires sign in" do
      let(:action) { get :new, chapter_id: @chapter.id}
    end
    it_behaves_like "requires admin" do
      let(:action) { get :new, chapter_id: @chapter.id }
    end
    
    it "sets the video to a new video" do
      set_current_admin
      get :new, chapter_id: @chapter.id
      expect(assigns(:video)).to be_instance_of(Video)
      expect(assigns(:video)).to be_new_record
    end

    it "assigns a chapter to the video" do
      set_current_admin
      get :new, chapter_id: @chapter.id
      expect(assigns(:video).chapter_id).to eq(@chapter.id) 
    end

    it "sets the flash error message for regular user" do
      set_current_user
      get :new, chapter_id: @chapter.id
      expect(flash[:error]).to be_present
    end
  end
  
  describe "POST #create" do
    before do
      @course = Fabricate(:course)
      @chapter = Fabricate(:chapter, course_id: @course.id)
    end
    it_behaves_like "requires sign in" do
      let(:action) { post :create, chapter_id: @chapter.id }
    end
    it_behaves_like "requires admin" do
      let(:action) { post :create, chapter_id: @chapter.id }
    end


    context "with invalid input" do
      it "renders the :new template" do
        set_current_admin
        post :create, chapter_id: @chapter.id, video: { description: "what you should know about a safety helmet", video_url: "http://diikjwpmj92eg.cloudfront.net/mod0/teach/safety_helmet.mp4", mins: 2, secs: 34, chapter_id: @chapter.id }
        expect(response).to render_template :new 
      end
      it "does not create a new chapter" do
        set_current_admin
        post :create, chapter_id: @chapter.id, video: { description: "what you should know about a safety helmet", video_url: "http://diikjwpmj92eg.cloudfront.net/mod0/teach/safety_helmet.mp4", mins: 2, secs: 34, chapter_id: @chapter.id }
        expect(Video.count).to eq(0) 
      end
      it "sets the @video variable" do
        set_current_admin
        post :create, chapter_id: @chapter.id, video: { description: "what you should know about a safety helmet", video_url: "http://diikjwpmj92eg.cloudfront.net/mod0/teach/safety_helmet.mp4", mins: 2, secs: 34, chapter_id: @chapter.id }
        expect(assigns(:video)).to be_present 
      end
      it "sets the flash error message" do
        set_current_admin
        post :create, chapter_id: @chapter.id, video: { description: "what you should know about a safety helmet", video_url: "http://diikjwpmj92eg.cloudfront.net/mod0/teach/safety_helmet.mp4", mins: 2, secs: 34, chapter_id: @chapter.id }
        expect(flash[:error]).to be_present 
      end
    end
  end
end
