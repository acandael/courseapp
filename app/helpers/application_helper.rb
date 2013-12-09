module ApplicationHelper
  def quiz_complete(user, quiz_id)
    user.quizzes.include?(Quiz.find(quiz_id))
  end

  def quiz_status(question)
    quiz = Quiz.find(question.quiz_id)
    questions = quiz.questions.sort
    "Question #{questions.index(question) + 1} of #{@quiz.questions.count}"
  end

  def percentage_completed(question)
    quiz = Quiz.find(question.quiz_id)
    questions = quiz.questions.sort
    ((questions.index(question) + 1) * 100) / questions.count
  end

  def total_time(chapter)
    min = 0
    sec = 0
    chapter.videos.each do |video|
      min += video.mins
      sec += video.secs
    end
    secs = (min * 60) + sec 
    Time.at(secs).utc.strftime("%H:%M:%S")
  end
end
