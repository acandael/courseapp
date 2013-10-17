# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

course = Course.create(title: "Course 1: VCA Basic Course", description: "This course is a preparation for the VCA Exam.")

CourseModule.create(title: "Wetgeving, gezondheid, milieu", description: "De basis met betrekking tot wetgeving, gezondheid en milieu", course_id: course.id)
CourseModule.create(title: "Toezicht op welzijn op het werk", description: "module behandeld alle aspecten met betrekking tot toezicht op welzijn op het werk", course_id: course.id)
CourseModule.create(title: "Inspectieprocedures", description: "grondige introductie tot de inspectieprocedures", course_id: course.id)
CourseModule.create(title: "Organisatie van Veiligheid Bescherming en Bescherming", description: "deze module bevat een overzicht van de organisatie van Veiligheid en Bescherming", course_id: course.id)
CourseModule.create(title: "De arbeidsinspectie", description: "in deze module wordt dieper ingegaan op de arbeidspectie", course_id: course.id)

 
