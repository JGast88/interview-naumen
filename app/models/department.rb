class Department < ApplicationRecord
	belongs_to :parent, :class_name => 'Department', optional: true
	has_many :children, :class_name => 'Department', :foreign_key => 'parent_id'
	has_many :active_periods

	#has_paper_trail only: [:name, :parent_id]
	
	validates :name, presence: true
	validates :created_at, presence: true
	validate :overlaps_with_parent_department
	

	# период существования 
	def active_timerange
			created_at..(disbanded_at || DateTime::Infinity.new)
	end

	private

	def overlaps_with_parent_department
		if parent.present? and active_timerange.overlaps?(parent.active_timerange)
			txt = %q(
				период нахождения дочернего отдела в родительском должен лежать в
				пределах периода существования родительского отдела (от даты
				формирования до даты расформирования)
			)
			errors.add(:base, txt)
		end
	end
end
