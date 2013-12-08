Fabricator :answer do
  title { Faker::Lorem.words(5).join(" ") }
  feedback { Faker::Lorem.paragraph(1) }
end
