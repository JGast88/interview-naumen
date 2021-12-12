class WorkingPeriod < ApplicationRecord
  belongs_to :department
  belongs_to :person

  validates :start_at, presence: true
  validate :periods_overlaps
  validate :working_only_at_one_department_at_time


	scope :overlapping_date, -> (date) do
    where("start_at <= ? AND (end_at > ? OR end_at IS NULL)", date, date)
	end
  scope :overlapping_with_department, -> (department, date) do
    d_wps = department.working_periods.overlapping_date(date)
    wps = WorkingPeriod.overlapping_date(date)
    d_wps & wps
  end
  default_scope { order(start_at: :asc) }

	def active_timerange
    start_at..(end_at || Date.new(9999,1,1))
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

    def working_only_at_one_department_at_time
      if person.working_periods.any?
        if person.working_periods.any?{|wp| wp.active_timerange.overlaps?(active_timerange)}
          txt = %q(
            сотрудник может переходить из отдела в любой момент
            работает только в одном отделе
          )
          errors.add(:base, txt)
        end
      end
    end
end
