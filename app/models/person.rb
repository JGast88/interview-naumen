class Person < ApplicationRecord
    has_many :working_periods
    has_many :departments, through: :working_periods

    validates :name, presence: true
end
