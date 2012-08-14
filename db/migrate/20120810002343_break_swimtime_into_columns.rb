class BreakSwimtimeIntoColumns < ActiveRecord::Migration
  def up
  	add_column :results, :swimtime_hours, :float
  	add_column :results, :swimtime_minutes, :float
  	add_column :results, :swimtime_seconds, :float

    add_column :splits, :swimtime_hours, :float
  	add_column :splits, :swimtime_minutes, :float
  	add_column :splits, :swimtime_seconds, :float

  	change_column :results, :swimtime, :string
  	change_column :splits, :swimtime, :string
  end

  def down
  	raise "don't do this"
  end
end
