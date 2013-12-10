Fabricator :video do
  title { Faker::Lorem.words(5).join(" ") }
  description { Faker::Lorem.paragraph(2) }
  mins { rand(1..60) }
  secs { rand(1..60) }
  video "fakevideofile.mp4" 
  chapter
end
