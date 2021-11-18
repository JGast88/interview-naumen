class Department < ApplicationRecord
	belongs_to :parent, :class_name => 'Department', optional: true
	has_many :children, :class_name => 'Department', :foreign_key => 'parent_id'
	has_many :active_periods
	has_many :working_periods

	has_paper_trail only: [:name, :parent_id]
	
	validates :name, presence: true
	validates :created_at, presence: true
	validate :overlaps_with_parent_department
	
	scope :overlapping_date, -> (date) do
		joins(:active_periods).where("active_periods.start_at < ? AND (active_periods.end_at > ? OR active_periods.end_at IS NULL )", date, date)
	end

	scope :filter_by_date, -> (date) do
		joins(:active_periods).where("active_periods.start_at < ? AND (active_periods.end_at > ? OR active_periods.end_at IS NULL )", date, date)
	end

	# отделы, которые существуют на заданную дату
	scope :relevant_on_date, -> (date) do
		active_periods.overlapping_date(date)
	end

	# название отдела на указанную дату
	def name_relevant_on_date(date)
	  active_periods.overlapping_date(date).order(:start_at).last.department_name
	end

	# период существования 
	def active_timerange
		created_at..(disbanded_at || DateTime::Infinity.new)
	end

	def people_working_on_date(date)
		if working_periods != nil
			wps = working_periods.overlapping_date(date)
			people_ids = wps.pluck(:person_id)
			Person.where(id: people_ids)  # TODO: refactor
		end
	end

	private

	def overlaps_with_parent_department
		if parent
			unless parent.active_timerange.cover?(active_timerange)
				txt = %q(
					период нахождения дочернего отдела в родительском должен лежать в
					пределах периода существования родительского отдела (от даты
					формирования до даты расформирования)
				)
				errors.add(:base, txt)
			end
		end
	end
end
