class ActivePeriod < ApplicationRecord
  belongs_to :department

  default_scope { order(start_at: :desc) }

	scope :overlapping_date, -> (date) do
    where("start_at <= ? AND (end_at > ? OR end_at IS NULL)", date, date)
	end
  
end
