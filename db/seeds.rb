# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if Course.count == 0
  course = Course.create(title: "Course 1: VCA Basic Course", description: "This course is a preparation for the VCA Exam.")
end

course = Course.find(1)

if course.chapters.count == 0
  chapter1 = Chapter.create(title: "Wetgeving, gezondheid, milieu", description: "De basis met betrekking tot wetgeving, gezondheid en milieu", course_id: course.id)
  chapter2 = Chapter.create(title: "Toezicht op welzijn op het werk", description: "In dit hoofdstuk gaan we dieper in op het toezicht van welzijn op het werk", course_id: course.id)
  chapter3 = Chapter.create(title: "Inspectieprocedures", description: "In dit hoofdstuk overlopen we de verschillende inspectieprocedures", course_id: course.id)
  chapter4 = Chapter.create(title: "Organisatie van Veiligheid Bescherming en Bescherming", description: "In dit hoofdstuk bespreken we de organisatie van veiligheid en bescherming", course_id: course.id)
  chapter5 = Chapter.create(title: "De arbeidsinspectie", description: "In dit hoofdstuk bespreken we de arbeidsinspectie", course_id: course.id)
end

chapter1 = Chapter.find(1)

if chapter1.videos.count == 0
video1 = Video.create(title: "Introduction", description: "description for video1",mins: 2, secs: 24, video_url: "http://diikjwpmj92eg.cloudfront.net/mod0/teach/Mod0-1.introduction.mp4", chapter_id: chapter1.id)
video2 = Video.create(title: "Basic Security", description: "description for video2", mins: 5, secs: 39, video_url: "http://diikjwpmj92eg.cloudfront.net/mod0/teach/Mod0-1.introduction.mp4", chapter_id: chapter1.id)
video3 = Video.create(title: "VCA law enforcment", description: "description for video3", mins: 6, secs: 23, video_url: "http://diikjwpmj92eg.cloudfront.net/mod0/teach/Mod0-1.introduction.mp4", chapter_id: chapter1.id)
video4 = Video.create(title: "Hazards and risk prevention", description: "description for video4", mins: 3, secs: 24, video_url: "http://diikjwpmj92eg.cloudfront.net/mod0/teach/Mod0-1.introduction.mp4", chapter_id: chapter1.id)
video5 = Video.create(title: "The safe workplace", description: "description for video5", mins: 4, secs: 24, video_url: "http://diikjwpmj92eg.cloudfront.net/mod0/teach/Mod0-1.introduction.mp4", chapter_id: chapter1.id)
end

if chapter1.quiz == 0
Quiz.create(title: "VCA Basic Security Quiz", success_message: "Congratulations, you just earned a VCA Basic Security Badge", chapter_id: chapter1.id)
end

quiz1 = Quiz.find(1)

if quiz1.questions.count == 0
  question1 = Question.create(title: "Which Official Body is responsible for enforcing VCA Legislation?", quiz_id: quiz1.id)
  question2 = Question.create(title: "Where was Napoleon born?", quiz_id: quiz1.id)
  question3 = Question.create(title: "What was the nationality of Mata Hari?", quiz_id: quiz1.id)
end

question1 = Question.find(1)

if question1.answers.count == 0
  answer1 = Answer.create(title: "COSHH", is_correct: true, question_id: question1.id)
  answer2 = Answer.create(title: "OSHI", is_correct: false, question_id: question1.id)
  answer3 = Answer.create(title: "The Health and Safety at Work etc. Act 1974", is_correct: false, question_id: question1.id)
end


