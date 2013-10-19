require 'spec_helper'

describe Course do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it "saves itself" do
    course = Course.new(title: "course1", description: "this is the description for course 1")
    course.save
    expect(Course.first).to eq(course)
  end
  
end
