require 'spec_helper'

feature "User interacts with course" do
  background do
     @course = Fabricate(:course)
     @chapter = Fabricate(:chapter, course_id: @course.id)
     @quiz = Fabricate(:quiz, chapter_id: @chapter.id)
     @question1 = Fabricate(:question, quiz_id: @quiz.id)
     @question2 = Fabricate(:question, quiz_id: @quiz.id)
     @answer = Fabricate(:answer, question_id: @question1.id)
     @answer2 = Fabricate(:answer, question_id: @question2.id)
  end
  scenario "user starts chapter and watches videos" do
   video1 = Fabricate(:video, chapter_id: @chapter.id)

   sign_in
   find("a[href='/chapters/#{@chapter.id}']").click
   page.should have_content(@chapter.title)
   find("a[href='/courses/#{@chapter.course_id}/chapters/#{video1.chapter_id}/video/#{video1.id}']").click
   page.should have_content(video1.description)
  end

  scenario "user takes quiz and answers question" do
    video1 = Fabricate(:video, chapter_id: @chapter.id)
     
    sign_in
    find("a[href='/chapters/#{@chapter.id}']").click
    click_link "Take the quiz"
    page.should have_content @quiz.title

    choose(@answer.title)
    click_button "Answer Question"

  end
end
