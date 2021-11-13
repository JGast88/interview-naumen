class CreateDepartments < ActiveRecord::Migration[6.1]
  def change
    create_table :departments do |t|
      t.string :name
      t.datetime :created_at
      t.datetime :disbanded_at
      t.integer :parent_id
    end
  end
end
