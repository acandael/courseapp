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
end
