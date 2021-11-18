class Person < ApplicationRecord
    has_many :working_periods
    has_many :departments, through: :working_periods

    validates :fullname, presence: true

    def working_periods_in_department(department)
        working_periods.where(department: department)
    end

    def department_on_date(department, date)
        if working_periods.overlapping_date(date).present?
            working_periods.overlapping_date(date).last.department
        end
    end

    def assigned_at_department_on_date(department, date)
        if working_periods.overlapping_date(date).present?
            working_periods.overlapping_date(date).last.start_at
        end
    end

end
