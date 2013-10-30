Fabricator(:chapter) do
  title { Faker::Lorem.words(5).join(" ") }
  description { Faker::Lorem.paragraph(2) } 
  tagline { Faker::Lorem.paragraph(1) }
  badge_image "some_fake_image.png"
end
