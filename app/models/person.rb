class Person < ApplicationRecord
    has_many :working_periods
    has_many :departments, through: :working_periods

    validates :name, presence: true

    def working_periods_in_department(department)
        working_periods.where(department: department)
    end
end
