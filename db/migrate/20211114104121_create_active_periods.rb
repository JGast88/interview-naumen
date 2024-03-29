class CreateActivePeriods < ActiveRecord::Migration[6.1]
  def change
    create_table :active_periods do |t|
      t.string :name
      t.datetime :start_at
      t.datetime :end_at, default: DateTime.new(9999, 1, 1)
      t.references :department, null: false, foreign_key: true
      t.integer :parent_id
    end
  end
end
