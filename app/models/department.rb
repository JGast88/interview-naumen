class Department < ApplicationRecord
    has_paper_trail only: [:name, :parent_id]
    
    validates :name, presence: true
    validates :created_at, presence: true
end
