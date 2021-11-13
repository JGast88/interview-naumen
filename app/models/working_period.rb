class WorkingPeriod < ApplicationRecord
  belongs_to :department
  belongs_to :person
end
