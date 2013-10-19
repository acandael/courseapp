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

if course
  chapter1 = Chapter.create(title: "Wetgeving, gezondheid, milieu", description: "De basis met betrekking tot wetgeving, gezondheid en milieu", course_id: course.id)
  chapter2 = Chapter.create(title: "Toezicht op welzijn op het werk", description: "In dit hoofdstuk gaan we dieper in op het toezicht van welzijn op het werk", course_id: course.id)
  chapter3 = Chapter.create(title: "Inspectieprocedures", description: "In dit hoofdstuk overlopen we de verschillende inspectieprocedures", course_id: course.id)
  chapter4 = Chapter.create(title: "Organisatie van Veiligheid Bescherming en Bescherming", description: "In dit hoofdstuk bespreken we de organisatie van veiligheid en bescherming", course_id: course.id)
  chapter5 = Chapter.create(title: "De arbeidsinspectie", description: "In dit hoofdstuk bespreken we de arbeidsinspectie", course_id: course.id)
end
