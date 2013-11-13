require 'spec_helper'

describe QuestionsController do
  describe "GET #show" do
    let(:course) { Fabricate(:course) } 
    let(:chapter) { Fabricate(:chapter, course_id: course.id) }
    let(:quiz) { Fabricate(:quiz, chapter_id: chapter.id) }
 
 
    it "returns the next question" do
      question1 = Fabricate(:question, quiz_id: quiz.id)
      question2 = Fabricate(:question, quiz_id: quiz.id)
      question3 = Fabricate(:question, quiz_id: quiz.id)
      get :show, quiz_id: quiz.id, id: question1.id
      expect(assigns(:question)).to eq(question2)
    end

    it "renders the quiz show template when not the last question in quiz" do
      question1 = Fabricate(:question, quiz_id: quiz.id)
      question2 = Fabricate(:question, quiz_id: quiz.id)
      question3 = Fabricate(:question, quiz_id: quiz.id)
      get :show, quiz_id: quiz.id, id: question1.id
      expect(response).to render_template :show 
    end


    it "shows quiz_success view when last question passed" do
      question1 = Fabricate(:question, quiz_id: quiz.id)
      question2 = Fabricate(:question, quiz_id: quiz.id)
      question3 = Fabricate(:question, quiz_id: quiz.id)
      get :show, quiz_id: quiz.id, id: question3.id
      expect(response).to redirect_to quiz_complete_path(id: question3.quiz_id)
    end
  end
end
