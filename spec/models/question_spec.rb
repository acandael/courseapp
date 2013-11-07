require 'spec_helper'

describe Question do
  it { should belong_to(:quiz) }
  it { should validate_presence_of(:title) }
  it "saves itself" do
    question = Question.new(title: "quiz1")
    question.save
    expect(Question.first).to eq(question)
  end

  it "belongs to a quiz" do
    quiz = Fabricate(:quiz)
    question = Fabricate(:question, quiz_id: quiz.id)
    expect(quiz.questions.first).to eq(question)
  end

  it "has many answers" do
    question = Fabricate(:question)
    answer1 = Fabricate(:answer, question_id: question.id)
    answer2 = Fabricate(:answer, question_id: question.id)
    expect(question.answers).to include(answer1, answer2)
  end

 end
