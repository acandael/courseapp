require 'spec_helper'

describe QuizzesController do
  describe "GET #show" do
    context "with valid user" do
      before do
        @course = Fabricate(:course)
        @chapter = Fabricate(:chapter, course_id: @course.id)
        @quiz = Fabricate(:quiz, chapter_id: @chapter.id)
      end
      it_behaves_like "requires sign in" do
        let(:action) { get :show, id: @quiz.id }
      end
      it "set @quiz" do
        set_current_user
        get :show, id: @quiz.id
        expect(assigns(:quiz)).to eq(@quiz)
      end

      it "returns first question when no question_id is send" do
        set_current_user
        course = Fabricate(:course)
        chapter = Fabricate(:chapter, course_id: course.id)
        quiz = Fabricate(:quiz, chapter_id: chapter.id)
        question1 = Fabricate(:question, quiz_id: quiz.id)
        question2 = Fabricate(:question, quiz_id: quiz.id)
        get :show, id: quiz.id, chapter_id: chapter.id 

        expect(assigns(:question)).to eq(question1)
      end

      it "returns the requested question" do
        set_current_user
        course = Fabricate(:course)
        chapter = Fabricate(:chapter, course_id: course.id)
        quiz = Fabricate(:quiz, chapter_id: chapter.id)
        question1 = Fabricate(:question, quiz_id: quiz.id)
        question2 = Fabricate(:question, quiz_id: quiz.id)
        get :show, id: quiz.id, chapter_id: chapter.id, question_id: question2.id

        expect(assigns(:question)).to eq(question2)
      end

      it "renders the show template" do
        set_current_user
        get :show, id: @quiz.id
        expect(response).to render_template :show 
      end
    end
    context "with invalid user" do
      before do
        @course = Fabricate(:course)
        @chapter = Fabricate(:chapter, course_id: @course.id)
        @quiz = Fabricate(:quiz, chapter_id: @chapter.id)
      end
      it "redirects to the sign in path" do
        get :show, id: @quiz.id
        expect(response).to redirect_to sign_in_path 
      end
    end
  end
end
