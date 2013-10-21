require 'spec_helper'

describe QuestionsController do

    let(:course) { Fabricate(:course) } 
    let(:chapter) { Fabricate(:chapter, course_id: course.id) }
    let(:quiz) { Fabricate(:quiz, chapter_id: chapter.id) }
 
 
    it "returns the next question" do
      question1 = Fabricate(:question, quiz_id: quiz.id)
      question2 = Fabricate(:question, quiz_id: quiz.id)
      question3 = Fabricate(:question, quiz_id: quiz.id)
      get :show, id: question1.id, next: true
      expect(assigns(:question)).to eq(question2)
    end

    it "redirects to show_question_path when not the last question in quiz" do
      question1 = Fabricate(:question, quiz_id: quiz.id)
      question2 = Fabricate(:question, quiz_id: quiz.id)
      question3 = Fabricate(:question, quiz_id: quiz.id)
      get :show, id: question1.id, next: true
      expect(response).to redirect_to show_question_path(id: question2.quiz_id, question_id: question2.id) 
    end


    it "shows quiz_success view when last question passed" do
      question1 = Fabricate(:question, quiz_id: quiz.id)
      question2 = Fabricate(:question, quiz_id: quiz.id)
      question3 = Fabricate(:question, quiz_id: quiz.id)
      get :show, id: question3.id
      expect(response).to redirect_to quiz_complete_path(id: question3.quiz_id)
    end
end
