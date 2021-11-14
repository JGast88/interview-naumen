class CreateActivePeriods < ActiveRecord::Migration[6.1]
  def change
    create_table :active_periods do |t|
      t.datetime :start_at
      t.datetime :end_at
      t.string :department_name
      t.string :parent_department_name
      t.references :department, null: false, foreign_key: true
    end
  end
end
