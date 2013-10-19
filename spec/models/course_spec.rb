require 'spec_helper'

describe Course do
  it { should have_many(:chapters) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it "saves itself" do
    course = Course.new(title: "course1", description: "this is the description for course 1")
    course.save
    expect(Course.first).to eq(course)
  end

  it "has many chapters" do
    course = Fabricate(:course)
    chapter1 = Fabricate(:chapter, course_id: course.id)
    chapter2 = Fabricate(:chapter, course_id: course.id)
    expect(course.chapters).to include(chapter1, chapter2)
  end
  
end
