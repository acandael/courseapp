require 'spec_helper'

describe Evaluation do
  context "evaluation succeeds" do
    let(:quiz) { quiz = Fabricate(:quiz) }
    let(:user) { user = Fabricate(:user) }
    let(:question) { Fabricate(:question, quiz_id: quiz.id) }
    let(:answer) { Fabricate(:answer, correct: true, question_id: question.id) }

    it "passes the quiz" do
      user.answers << answer
      evaluation = Evaluation.new(quiz, user)
      expect(evaluation.pass?).to be_true
    end

    it "adds the quiz to the users quizzes when quiz complete" do
      user.answers << answer
      evaluation = Evaluation.new(quiz, user)
      evaluation.pass?
      expect(user.quizzes.first).to eq(quiz) 
    end
  end

  context "evaluation fails" do
    let(:quiz) { quiz = Fabricate(:quiz) }
    let(:user) { user = Fabricate(:user) }
    let(:question1) { Fabricate(:question, quiz_id: quiz.id) }
    let(:question2) { Fabricate(:question, quiz_id: quiz.id) }
    let(:question3) { Fabricate(:question, quiz_id: quiz.id) }
    let(:answer1) { Fabricate(:answer, correct: false, question_id: question1.id) }
    let(:answer2) { Fabricate(:answer, correct: false, question_id: question2.id) }
    let(:answer3) { Fabricate(:answer, correct: false, question_id: question3.id) }



    it "doesn't pass the quiz" do
      user.answers << [ answer1, answer2, answer3 ]
      evaluation = Evaluation.new(quiz, user)
      expect(evaluation.pass?).to be_false
    end

    it "does not add the quiz to the user's quizzes when quiz is not passed" do
      user.answers << [ answer1, answer2, answer3 ]
      evaluation = Evaluation.new(quiz, user)
      evaluation.pass?
      expect(user.quizzes).to eq([]) 
    end
  end
end
