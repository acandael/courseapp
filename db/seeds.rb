# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

course = Course.create(title: "Course 1: VCA Basic Course", description: "This course is a preparation for the VCA Exam.")

mod = CourseModule.create(title: "Wetgeving, gezondheid, milieu", description: "De basis met betrekking tot wetgeving, gezondheid en milieu", course_id: course.id)
CourseModule.create(title: "Toezicht op welzijn op het werk", description: "module behandeld alle aspecten met betrekking tot toezicht op welzijn op het werk", course_id: course.id)
CourseModule.create(title: "Inspectieprocedures", description: "grondige introductie tot de inspectieprocedures", course_id: course.id)
CourseModule.create(title: "Organisatie van Veiligheid Bescherming en Bescherming", description: "deze module bevat een overzicht van de organisatie van Veiligheid en Bescherming", course_id: course.id)
CourseModule.create(title: "De arbeidsinspectie", description: "in deze module wordt dieper ingegaan op de arbeidspectie", course_id: course.id)

Video.create(title: "Introduction", mins: 2, secs: 24, video_url: "http://diikjwpmj92eg.cloudfront.net/mod0/teach/Mod0-1.introduction.mp4", course_module_id: mod.id)
Video.create(title: "Basic Security", mins: 5, secs: 39, video_url: "http://diikjwpmj92eg.cloudfront.net/mod0/teach/Mod0-1.introduction.mp4", course_module_id: mod.id)
Video.create(title: "VCA law enforcment", mins: 6, secs: 23, video_url: "http://diikjwpmj92eg.cloudfront.net/mod0/teach/Mod0-1.introduction.mp4", course_module_id: mod.id)
Video.create(title: "Hazards and risk prevention", mins: 3, secs: 24, video_url: "http://diikjwpmj92eg.cloudfront.net/mod0/teach/Mod0-1.introduction.mp4", course_module_id: mod.id)
Video.create(title: "The safe workplace", mins: 4, secs: 24, video_url: "http://diikjwpmj92eg.cloudfront.net/mod0/teach/Mod0-1.introduction.mp4", course_module_id: mod.id)
