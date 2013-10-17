require 'spec_helper'

describe CourseModule do
  it { should belong_to(:course) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it "saves itself" do
    course_module = CourseModule.new(title: "module1", description: "this is the description for module1")
    course_module.save
    expect(CourseModule.first). to eq(course_module)
  end
end
