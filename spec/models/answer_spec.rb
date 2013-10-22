require 'spec_helper'

describe Answer do
  it { should belong_to(:question) }
  it { should validate_presence_of(:title) }
  it "saves itself" do
    answer = Answer.new(title: "answer1")
    answer.save
    expect(Answer.first).to eq(answer)
  end

  it "belongs to a question" do
    question = Fabricate(:question)
    answer = Fabricate(:answer, question_id: question.id)
    expect(question.answers.first).to eq(answer)
  end

  it "returns true when answer is_correct" do
    answer = Fabricate(:answer)
    answer.is_correct = true
    expect(answer.is_correct).to be_true
  end

  it "returns false when answer is not correct" do
    answer = Fabricate(:answer)
    answer.is_correct = false
    expect(answer.is_correct).to be_false
  end
end