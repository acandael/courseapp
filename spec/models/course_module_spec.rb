require 'spec_helper'

describe CourseModule do
  it { should belong_to(:course) }
  it { should have_many(:videos) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it "saves itself" do
    course_module = CourseModule.new(title: "module1", description: "this is the description for module1")
    course_module.save
    expect(CourseModule.first). to eq(course_module)
  end

  it "belongs to course" do
    course = Course.create(title: "course1", description: "description for course 1") 
    module1 = CourseModule.create(title: "module 1", description: "description for module 1", course_id: course.id)
    expect(course.course_modules.first).to eq(module1)
  end

  it "has many videos" do
course_module = Fabricate(:course_module) 
    video1 = Fabricate(:video) 
    video1.course_module_id = course_module.id
    course_module.videos << video1
    video2 = Fabricate(:video) 
    video2.course_module_id = course_module.id
    course_module.videos << video2
    expect(course_module.videos).to include(video1, video2)
  end
end
