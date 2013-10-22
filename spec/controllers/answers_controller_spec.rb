require 'spec_helper'

describe AnswersController do
  describe 'POST @check_answer' do

    it "redirects to the next question" do
      quiz = Fabricate(:quiz)
      question1 = Fabricate(:question, quiz_id: quiz.id)
      question2 = Fabricate(:question, quiz_id: quiz.id)
      answer = Fabricate(:answer, question_id: question1.id)
      post :check_answer, id: answer.id
      expect(response).to redirect_to show_question_path(id: question2.quiz_id, question_id: question2.id)
    end

    it "redirects to quiz_complete_path when question is last question" do
      quiz = Fabricate(:quiz)
      question1 = Fabricate(:question, quiz_id: quiz.id)
      question2 = Fabricate(:question, quiz_id: quiz.id)
      question3 = Fabricate(:question, quiz_id: quiz.id)
      answer = Fabricate(:answer, question_id: question3.id)
      post :check_answer, id: answer.id
      expect(response).to redirect_to quiz_complete_path(id: question3.quiz_id)

    end
    
  end
end
