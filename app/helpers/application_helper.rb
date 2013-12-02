module ApplicationHelper
  def quiz_complete(user, quiz_id)
    user.quizzes.include?(Quiz.find(quiz_id))
  end
end
