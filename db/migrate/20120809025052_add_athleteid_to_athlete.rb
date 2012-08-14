class AddAthleteidToAthlete < ActiveRecord::Migration
  def change
  	add_column :athletes, :athleteid, :integer
  end
end
