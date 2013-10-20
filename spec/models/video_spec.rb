require 'spec_helper'

describe Video do
  it { should belong_to(:chapter) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:mins) }
  it { should validate_presence_of(:secs) }
  it { should validate_presence_of(:video_url) }
  it "saves itself" do
    video = Fabricate(:video)
    video.save
    expect(Video.first).to eq(video)
  end

  it "belongs to a chapter" do
    chapter = Fabricate(:chapter)
    video = Fabricate(:video, chapter_id: chapter.id)
    expect(chapter.videos.first).to eq (video)
  end
end
