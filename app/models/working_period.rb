class WorkingPeriod < ApplicationRecord
  belongs_to :department
  belongs_to :person

  validate :periods_overlaps

	scope :overlapping_date, -> (date) do
    where("start_at < ? AND end_at > ?", date, date)
	end

	def active_timerange
    start_at..(end_at || DateTime::Infinity.new)
  end

  private
    def periods_overlaps
      unless department.active_timerange.cover?(active_timerange)
        txt = %q(
          период работы сотрудника в отделе должен лежать в пределах периода
          существования отдела
        )
        errors.add(:base, txt)
      end
    end
end
