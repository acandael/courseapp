require 'spec_helper'

describe Admin::VideosController do
  describe "GET #show" do
    before do
      @chapter = Fabricate(:chapter)
      @video = Fabricate(:video, chapter_id: @chapter.id)
    end
    it_behaves_like "requires sign in" do
      let(:action) { get :show, chapter_id: @chapter.id, id: @video.id }
    end
    it_behaves_like "requires admin" do
      let(:action) { get :show, chapter_id: @chapter.id, id: @video.id }
    end
    context "with valid user" do
      it "renders the :show template" do
        set_current_admin
        get :show, chapter_id: @chapter.id, id: @video.id
        expect(response).to render_template :show
      end
      it "returns a video" do
        set_current_admin
        get :show, chapter_id: @chapter.id, id: @video.id
        expect(assigns(:video)).to be_present 
      end
      it "returns a video for the chapter" do
        set_current_admin
        get :show, chapter_id: @chapter.id, id: @video.id
        expect(assigns(:video).chapter_id).to eq(@video.chapter_id) 
      end
    end
    context "with invalid user" do
      it "redirects to the sign in page" do
        get :show, chapter_id: @chapter.id, id: @video.id
        expect(response).to redirect_to sign_in_path 
      end
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
      expect(flash[:alert]).to be_present
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
        expect(flash[:alert]).to be_present 
      end
    end
  end

  describe "PUT #update" do
    before do
      @course = Fabricate(:course)
      @chapter = Fabricate(:chapter, course_id: @course.id)
      @video = Fabricate(:video, chapter_id: @chapter.id )
    end
    it_behaves_like "requires sign in" do
      let(:action) { put :update, chapter_id: @chapter.id, id: @video.id }
    end
    it_behaves_like "requires admin" do
      let(:action) { put :update, chapter_id: @chapter.id, id: @video.id }
    end
    context "with valid input" do
      it "redirects to the video show page" do
        set_current_admin
        @video.title = "new title"
        put :update, chapter_id: @chapter.id, id: @video.id, video: { title: "new title", description: "what you should know about a safety helmet", video_url: "http://diikjwpmj92eg.cloudfront.net/mod0/teach/safety_helmet.mp4", mins: 2, secs: 34, chapter_id: @chapter.id }
        expect(response).to redirect_to admin_chapter_video_path(@video.chapter_id, @video.id) 
      end
      it "updates the video" do
        set_current_admin
        put :update, chapter_id: @chapter.id, id: @video.id, video: { title: "new title", description: "what you should know about a safety helmet", video_url: "http://diikjwpmj92eg.cloudfront.net/mod0/teach/safety_helmet.mp4", mins: 2, secs: 34, chapter_id: @chapter.id }
        @video.reload
        expect(assigns(:video).title).to eq("new title") 
      end
      it "sets the flash success message" do
        set_current_admin
        put :update, chapter_id: @chapter.id, id: @video.id, video: { title: "new title", description: "what you should know about a safety helmet", video_url: "http://diikjwpmj92eg.cloudfront.net/mod0/teach/safety_helmet.mp4", mins: 2, secs: 34, chapter_id: @chapter.id }
        @video.reload
        expect(flash[:success]).to be_present 
      end
    end
    context "with invalid input" do
      it "renders the :edit template" do
        set_current_admin
        put :update, chapter_id: @chapter.id, id: @video.id, video: { title: "new title", description: "", video_url: "http://diikjwpmj92eg.cloudfront.net/mod0/teach/safety_helmet.mp4", mins: 2, secs: 34, chapter_id: @chapter.id }
        @video.reload
        expect(response).to render_template :edit 
      end
      it "does not update the video" do
        set_current_admin
        put :update, chapter_id: @chapter.id, id: @video.id, video: { title: "new title", description: "", video_url: "http://diikjwpmj92eg.cloudfront.net/mod0/teach/safety_helmet.mp4", mins: 2, secs: 34, chapter_id: @chapter.id }
        @video.reload
        expect(@video.description).not_to eq("")
      end
      it "sets a flash error message" do
        set_current_admin
        put :update, chapter_id: @chapter.id, id: @video.id, video: { title: "new title", description: "", video_url: "http://diikjwpmj92eg.cloudfront.net/mod0/teach/safety_helmet.mp4", mins: 2, secs: 34, chapter_id: @chapter.id }
        @video.reload
        expect(flash[:alert]).to be_present 
      end
      it "sets the @video" do
        set_current_admin
        put :update, chapter_id: @chapter.id, id: @video.id, video: { title: "new title", description: "", video_url: "http://diikjwpmj92eg.cloudfront.net/mod0/teach/safety_helmet.mp4", mins: 2, secs: 34, chapter_id: @chapter.id }
        @video.reload
        expect(assigns(:video)).to be_present 
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      @chapter = Fabricate(:chapter)
      @video = Fabricate(:video, chapter_id: @chapter.id )
    end
    it_behaves_like "requires sign in" do
      let(:action) { delete :destroy, chapter_id: @chapter.id, id: @video.id }
    end
    it_behaves_like "requires admin" do
      let(:action) { delete :destroy, chapter_id: @chapter.id, id: @video.id }
    end
    context "with valid user" do
      it "redirects to the chapter show page" do
        set_current_admin
        delete :destroy, chapter_id: @chapter.id, id: @video.id
        expect(response).to redirect_to admin_chapter_path(@chapter.id)
      end
      it "deletes the video" do
        set_current_admin
        delete :destroy, chapter_id: @chapter.id, id: @video.id
        expect(@chapter.videos.count).to eq(0)
      end
      it "sets the flash success message" do
        set_current_admin
        delete :destroy, chapter_id: @chapter.id, id: @video.id
        expect(flash[:success]).to be_present 
      end

    end
  end
end
