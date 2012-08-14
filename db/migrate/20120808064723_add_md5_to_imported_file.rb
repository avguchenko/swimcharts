class AddMd5ToImportedFile < ActiveRecord::Migration
  def change
  		add_column :imported_files, :md5, :text
  end
end
