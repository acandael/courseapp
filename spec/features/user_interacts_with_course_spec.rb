require 'spec_helper'

feature "User interacts with course" do
  background do
    @course = Fabricate(:course)
  end
  scenario "user starts chapter and watches videos" do
   chapter1 = Fabricate(:chapter, course_id: @course.id)
   quiz1 = Fabricate(:quiz, chapter_id: chapter1.id)
   video1 = Fabricate(:video, chapter_id: chapter1.id)

   sign_in
   find("a[href='/chapters/#{chapter1.id}']").click
   page.should have_content(chapter1.title)
   find("a[href='/chapters/#{chapter1.id}/videos/#{video1.id}']").click
   page.should have_content(video1.description)
  end

  scenario "user takes quiz and answers question" do
    chapter1 = Fabricate(:chapter, course_id: @course.id)
    quiz1 = Fabricate(:quiz, chapter_id: chapter1.id)
    question1 = Fabricate(:question, quiz_id: quiz1.id)
    question2 = Fabricate(:question, quiz_id: quiz1.id)
    answer1 = Fabricate(:answer, is_correct: 1, question_id: question1.id)
    answer2 = Fabricate(:answer, is_correct: 0, question_id: question2.id)
    question1.answers << answer1
    question2.answers << answer2
    quiz1.questions << question1 
    quiz1.questions << question2
    video1 = Fabricate(:video, chapter_id: chapter1.id)
    chapter1.videos << video1
    chapter1.quiz = quiz1 
     
    sign_in
    find("a[href='/chapters/#{chapter1.id}']").click
    click_link "Take the quiz"
    page.should have_content quiz1.title

    choose(answer1.title)
    click_button "Answer Question"
  end
end
