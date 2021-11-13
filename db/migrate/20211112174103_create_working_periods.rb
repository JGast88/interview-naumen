class CreateWorkingPeriods < ActiveRecord::Migration[6.1]
  def change
    create_table :working_periods do |t|
      t.datetime :start_at, null: false
      t.datetime :end_at
    end
  end
end
