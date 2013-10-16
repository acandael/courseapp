require 'spec_helper'

describe Course do
  it "saves itself" do
    course = Course.new(title: "course1", description: "this is the description for course 1")
    course.save
    expect(course.first).to eq(course)
  end
  
end
