class WorkingPeriod < ApplicationRecord
  belongs_to :department
  belongs_to :person

  validate :periods_overlaps


	def active_timerange
    start_at..(end_at || DateTime::Infinity.new)
  end

  private
    def periods_overlaps
      unless department.active_timerange.include?(active_timerange)
        txt = %q(
          период работы сотрудника в отделе должен лежать в пределах периода
          существования отдела
        )
        errors.add(:base, txt)
      end
    end
end
