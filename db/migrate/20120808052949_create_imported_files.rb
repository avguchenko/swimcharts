class CreateImportedFiles < ActiveRecord::Migration
  def change
    create_table :imported_files do |t|
      t.string :file_id
      t.string :url

      t.timestamps
    end
  end
end
