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

  it "raises an exception when a second correct answer is added" do
    question = Fabricate(:question)
    answer1 = Fabricate(:answer, is_correct: true, question_id: question.id)
    answer1.save
    expect(Answer.create(is_correct: true, question_id: question.id)).to raise_error
  end

end
