class AddYearToMeet < ActiveRecord::Migration
  def change
  	add_column :meets, :year, :integer
  end
end
