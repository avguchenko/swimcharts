class AddMeetIdToImportedFiles < ActiveRecord::Migration
  def change
  	add_column :imported_files, :meet_id, :integer
  end
end
