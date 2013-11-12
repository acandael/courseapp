require 'spec_helper'

feature "Admin interacts with course" do
  scenario "admin adds a new course" do
    admin = Fabricate(:admin)
    Fabricate(:course)
    sign_in(admin)

    visit admin_courses_path
    click_link "Add Course"
    
    fill_in "Course Title:", with: "the safe workplace"
    fill_in "Course Description:", with: "What you should know about a safe workplace"
    click_button "Add Course"
    page.should have_content "the safe workplace"
  end

  scenario "admin edits a course" do
    admin = Fabricate(:admin)
    course = Fabricate(:course)
    sign_in(admin)
    visit admin_courses_path
    find("a[href='/admin/courses/#{course.id}']").click
    click_link "Edit"
    find("input[@id='course_title']").set("a safer workplace")
    click_button "Update Course"
    page.should have_content "a safer workplace"
  end
end
