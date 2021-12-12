class CreateWorkingPeriods < ActiveRecord::Migration[6.1]
  def change
    create_table :working_periods do |t|
      t.datetime :start_at, null: false
      t.datetime :end_at, default: DateTime.new(9999, 1, 1)
    end
  end
end
