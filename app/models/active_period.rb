class ActivePeriod < ApplicationRecord
  belongs_to :department
	belongs_to :parent_department, :class_name => 'Department', :foreign_key => 'parent_id', optional: true
	#has_many :children_departments, :class_name => 'Department', :foreign_key => 'parent_id'
  
	validates :name, presence: true

	scope :overlapping_date, -> (date) do
    where("start_at <= ? AND (end_at > ? OR end_at IS NULL)", date, date)
	end
	scope :roots, -> { where(parent_id: nil) }
  default_scope { order(start_at: :asc) }

	def parent_department
		Department.find_by(id: parent_id)
	end

	def children_departments(date = Date.today)
		aps = ActivePeriod.overlapping_date(date).where(parent_id: department_id)
		Department.where(id: aps.pluck(:department_id))
	end
  
end
