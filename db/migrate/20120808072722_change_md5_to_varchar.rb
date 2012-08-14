class ChangeMd5ToVarchar < ActiveRecord::Migration
  def up
  	change_table :imported_files do |t|
      t.change :md5, :string
    end
  end

  def down
  	raise "nope"
  end
end
