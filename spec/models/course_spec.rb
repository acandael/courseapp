require 'spec_helper'

describe Course do
  it { should have_many(:course_modules) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it "saves itself" do
    course = Course.new(title: "course1", description: "this is the description for course 1")
    course.save
    expect(Course.first).to eq(course)
  end

  it "has many coursemodules" do
    course = Course.create(title: "course1", description: "description for course 1")
    module1 = CourseModule.create(title: "module1", description: "description for module 1", course_id: course.id)
    course.course_modules << module1
    module2 = CourseModule.create(title: "module2", description: "description for module 2", course_id: course.id)
    course.course_modules << module2
    expect(course.course_modules).to include(module1, module2)
  end
end
