require 'spec_helper'

describe Chapter do
  it { should belong_to(:course) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it "saves itself" do
    chapter = Fabricate(:chapter)
    chapter.save
    expect(Chapter.first).to eq(chapter)
  end

  it "belongs to a course" do
    course = Fabricate(:course)
    chapter = Fabricate(:chapter, course_id: course.id)
    expect(course.chapters.first).to eq(chapter)
  end

  it "has many videos" do
    chapter = Fabricate(:chapter)
    video1 = Fabricate(:video, chapter_id: chapter.id)
    video2 = Fabricate(:video, chapter_id: chapter.id)
    expect(chapter.videos).to include(video1, video2)
  end

  it "has one quiz" do
    chapter = Fabricate(:chapter)
    quiz = Fabricate(:quiz, chapter_id: chapter.id)
    expect(chapter.quiz).to eq(quiz)
  end
end
