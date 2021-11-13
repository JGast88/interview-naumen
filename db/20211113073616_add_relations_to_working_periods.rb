class AddRelationsToWorkingPeriods < ActiveRecord::Migration[6.1]
  def change
    add_reference :working_periods, :department, foreign_key: true
    add_reference :working_periods, :person, foreign_key: true
  end
end
