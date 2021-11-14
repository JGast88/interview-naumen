class Department < ApplicationRecord
    belongs_to :parent, :class_name => 'Department', optional: true
    has_many :children, :class_name => 'Department', :foreign_key => 'parent_id'
    has_many :active_periods

    #has_paper_trail only: [:name, :parent_id]
    
    validates :name, presence: true
    validates :created_at, presence: true
end
