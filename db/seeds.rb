people = ["Илон Маск", "Джефф Безос", "Ричард Бренсон"]
departments = ["Отдел заказов", "Отдел сбыта", "Отдел закупок", "Проектный отдел", "Расчетный отдел", "Конструкторский отдел"]
initial_date = Date.new(2021, 12, 1)

people.each do |name|
    Person.create!(fullname: name)
end

departments.each_with_index do |name, i|
    department = Department.create!(
        name: name,
        created_at: initial_date + i.days
    )
    department.active_periods.create!(
        name: name,
        start_at: department.created_at
    )
end