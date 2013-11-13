require 'spec_helper'

describe AnswersController do
  describe 'POST @check_answer' do
  end

  describe 'PUT #update' do
    before do
      @quiz = Fabricate(:quiz)
      @question1 = Fabricate(:question, quiz_id: @quiz.id)
    end
    it "redirects to the question show page" do
      answer1 = Fabricate(:answer, question_id: @question1.id)
      patch :update, question_id: @question1.id, id: answer1.id
      expect(response).to redirect_to quiz_question_path(@quiz.id, @question1.id)
    end
  end
end
