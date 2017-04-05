# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ENV['DISABLE_GEOCODING'] = 'true'

user = User.create!(
  email:    'email@email.com',
  password: 'TestPass',
  username: 'testuser'
)
user.confirm

cities = [
  "Kraków, Polska",
  "Warszawa, Polska",
  "Łódź, Polska",
  "Nowy Jork, Ameryka"
]

addresses = [
  "Makowskiego 1, Kraków, Polska",
  "Mikołajska 2, Kraków, Polska",
  "Krowoderska 3, Kraków, Polska",
  "Warszawska 4, Kraków, Polska",
  "Przemyska 5, Kraków, Polska",
  "Starowiślna 6, Kraków, Polska",
  "Akademicka 7, Kraków, Polska",
]

puts 'Creating sample bands'
rand(30).times do |i|
  Band.create!(name: Faker::Company.name, location: cities.sample)
  print '.'
end
puts

puts 'Creating sample venues'
rand(30).times do |i|
  Venue.create!(name: Faker::Company.name, address: addresses.sample)
  print '.'
end
puts

puts 'Creating sample past events'
rand(30).times do |i|
  event = Event.create!(
    name:  Faker::Company.name,
    venue: Venue.order('RANDOM()').first,
    beginning_at: Time.zone.now - rand(20).days,
    user: user,
    ownership_type: 'user'
  )

  rand(4).times do |i|
    event.bands << Band.order('RANDOM()').first
  end

  print '.'
end
puts

puts 'Creating sample upcoming events'
rand(30).times do |i|
  event = Event.create!(
    name:  Faker::Company.name,
    venue: Venue.order('RANDOM()').first,
    beginning_at: Time.zone.now + rand(20).days,
    user: user,
    ownership_type: 'user'
  )

  rand(4).times do |i|
    event.bands << Band.order('RANDOM()').first
  end

  print '.'
end
puts