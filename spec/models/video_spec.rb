require 'spec_helper'

describe Video do
  it { should belong_to(:course_module) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:mins) }
  it { should validate_presence_of(:secs) }
  it { should validate_presence_of(:video_url) }
  it "saves itself" do
    video = Fabricate(:video)
    video.save
    expect(Video.first). to eq(video)
  end

  it "belongs to course_module" do
    course_module = Fabricate(:course_module)
    video1 = Fabricate(:video, course_module_id: course_module.id)
    expect(course_module.videos.first).to eq(video1)
  end
end
