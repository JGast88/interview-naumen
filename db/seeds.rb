# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

people = ["Илон Маск", "Джефф Безос", "Ричард Бренсон"]
departments = ["Отдел заказов", "Отдел сбыта", "Отдел закупок", "Проектный отдел", "Расчетный отдел", "Конструкторский отдел"]
initial_date = Date.new(2021, 12, 1)

# create 10 People in DB
people.each do |name|
    Person.create!(
        fullname: name
    )
end

# create 10 tickets in DB
departments.each_with_index do |name, i|
    Department.create!(
        name: name,
        created_at: initial_date + i.days
    )
end