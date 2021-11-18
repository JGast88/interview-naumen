# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create 10 People in DB
(1..10).each do |id|
    Person.create!(
        id: id, 
        name: Faker::Name.name
    )
end

# create 10 tickets in DB
(1..10).each do |id|
    Department.create!(
        id: id,
        name: Faker::Company.name
    )
end