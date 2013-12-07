require 'spec_helper'

describe Quiz do
  it { should belong_to(:chapter) }
  it { should validate_presence_of(:title) }
  it "saves itself" do
    quiz = Quiz.new(title: "quiz1")
    quiz.save
    expect(Quiz.first).to eq(quiz)
  end

  it "belongs to a chapter" do
    chapter = Fabricate(:chapter)
    quiz = Fabricate(:quiz, chapter_id: chapter.id)
    expect(chapter.quiz).to eq(quiz)
  end

  it "has many questions" do
    chapter = Fabricate(:chapter)
    quiz = Fabricate(:quiz)
    question1 = Fabricate(:question, quiz_id: quiz.id)
    question2 = Fabricate(:question, quiz_id: quiz.id)
    expect(quiz.questions).to include(question1, question2)
  end

  it "finds the next question" do
    quiz = Fabricate(:quiz)
    question1 = Fabricate(:question, quiz_id: quiz.id)
    question2 = Fabricate(:question, quiz_id: quiz.id)
    question3 = Fabricate(:question, quiz_id: quiz.id)
    expect(Question.next(question1.id)).to eq(question2)
  end

end
