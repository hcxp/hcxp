# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

50.times do
  Event.create!(
    name: Faker::Company.catch_phrase,
    start_at: DateTime.now + [rand(100), -rand(100)].sample.days,
    city: ['Kraków', 'Gdańsk', 'Warszawa', 'Gdynia', 'Toruń'].sample,
    country_code: 'PL'
  )
end
