Fabricator :video do
  title { Faker::Lorem.words(5).join(" ") }
  description { Faker::Lorem.paragraph(2) }
  mins { rand(1..60) }
  secs { rand(1..60) }
  video_url "http://diikjwpmj92eg.cloudfront.net/mod0/teach/Mod0-1.introduction.mp4"
end
