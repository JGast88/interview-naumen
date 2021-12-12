class Department < ApplicationRecord
	#belongs_to :parent, :class_name => 'Department', optional: true
	#has_many :children, :class_name => 'Department', :foreign_key => 'parent_id'
	has_many :active_periods, dependent: :destroy
	has_many :working_periods, dependent: :destroy

	has_paper_trail only: [:name, :parent_id]
	
	validates :name, presence: true
	validates :created_at, presence: true
	validate :overlaps_with_parent_department
	
	scope :overlapping_date, -> (date) do
		#joins(:active_periods).where("active_periods.start_at < ? AND active_periods.end_at IS NULL", date)
		#.or(where("active_periods.start_at < ? AND active_periods.end_at > ?", date, date))
		joins(:active_periods).where("active_periods.start_at <= ? AND (active_periods.end_at IS NULL OR active_periods.end_at > ? )", date, date)
	end

	scope :filter_by_date, -> (date) do
		joins(:active_periods).where("active_periods.start_at <= ? AND (active_periods.end_at IS NULL OR active_periods.end_at > ? )", date, date)
	end
	# отделы, которые существуют на заданную дату
	scope :relevant_on_date, -> (date) do
		active_periods.overlapping_date(date)
	end
	scope :roots, -> (date) do
		where(id: ActivePeriod.overlapping_date(date).roots&.pluck(:department_id))
	end

	after_commit :set_active_period_end_on_disband

	def current_active_period(date = Date.today)
		active_periods.overlapping_date(date).last if active_periods.any? and active_periods.overlapping_date(date).any?
	end

	# название отдела на указанную дату
	def name_on_date(date = Date.today)
		current_active_period(date)&.name
	end

	def parent_id(date = Date.today)
		if active_periods.any?
			if active_periods.overlapping_date(date).any?
				active_periods.overlapping_date(date).first.parent_id
			else
				active_periods.last.parent_id 
			end
		else
			0
		end
	end

	def parent(date = Date.today)
		Department.find_by(id: parent_id(date))
	end

	#def parent(date = Date.today)
	#	if active_periods.overlapping_date(date).any?
	#		aps = active_periods.overlapping_date(date)
	#		Department.find_by(id: aps.last[:department_id])
	#	end
	#end

	def children(date = Date.today)
		aps = ActivePeriod.overlapping_date(date).where(parent_id: id)
		Department.where(id: aps.pluck(:department_id))
	end

	def parent_on_date(date = Date.today)
		if active_periods.overlapping_date(date).any?
			parent = Department.find(current_active_period(date).parent_id)
			parent.name
		else
			"No parent name"
		end
	end

	# период существования 
	def active_timerange
		created_at..(disbanded_at || Date.new(9999,1,1) )
	end

	def people_working_on_date(date = Date.today)
		if working_periods != nil
			wps = working_periods.overlapping_date(date)
			people_ids = wps.pluck(:person_id)
			Person.where(id: people_ids)  # TODO: refactor
		end
	end

	def set_active_period_end_on_disband
		active_periods.last.update(end_at: disbanded_at) if disbanded_at.present? 
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
