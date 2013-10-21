require 'spec_helper'

describe QuizzesController do
  describe "GET #show" do
    it "set @quiz" do
      course = Fabricate(:course)
      chapter = Fabricate(:chapter, course_id: course.id)
      quiz = Fabricate(:quiz, chapter_id: chapter.id)
      get :show, id: quiz.id, chapter_id: chapter.id
      expect(assigns(:quiz)).to eq(quiz)
    end

    it "set @chapter" do
      course = Fabricate(:course)
      chapter = Fabricate(:chapter, course_id: course.id)
      quiz = Fabricate(:quiz, chapter_id: chapter.id)
      get :show, id: quiz.id, chapter_id: chapter.id
      expect(assigns(:chapter)).to eq(chapter)
    end

    it "set @course" do
      course = Fabricate(:course)
      chapter = Fabricate(:chapter, course_id: course.id)
      quiz = Fabricate(:quiz, chapter_id: chapter.id)
      get :show, id: quiz.id, chapter_id: chapter.id
      expect(assigns(:course)).to eq(course)
    end

    it "set @question" do
      course = Fabricate(:course)
      chapter = Fabricate(:chapter, course_id: course.id)
      quiz = Fabricate(:quiz, chapter_id: chapter.id)
      question = Fabricate(:question, quiz_id: quiz.id)
      get :show, id: quiz.id, chapter_id: chapter.id, question_id: question.id
      expect(assigns(:question)).to eq(question)
    end

    it "returns first question when no question_id is send" do
      course = Fabricate(:course)
      chapter = Fabricate(:chapter, course_id: course.id)
      quiz = Fabricate(:quiz, chapter_id: chapter.id)
      question1 = Fabricate(:question, quiz_id: quiz.id)
      question2 = Fabricate(:question, quiz_id: quiz.id)
      get :show, id: quiz.id, chapter_id: chapter.id 

      expect(assigns(:question)).to eq(question1)
    end

    it "returns the requested question" do
      course = Fabricate(:course)
      chapter = Fabricate(:chapter, course_id: course.id)
      quiz = Fabricate(:quiz, chapter_id: chapter.id)
      question1 = Fabricate(:question, quiz_id: quiz.id)
      question2 = Fabricate(:question, quiz_id: quiz.id)
      get :show, id: quiz.id, chapter_id: chapter.id, question_id: question2.id

      expect(assigns(:question)).to eq(question2)
    end
  end
end
