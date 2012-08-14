class RenameTypeToClubtype < ActiveRecord::Migration
  def up
  		rename_column :clubs, :type, :club_type
  end

  def down
  	raise "don't"
  end
end
