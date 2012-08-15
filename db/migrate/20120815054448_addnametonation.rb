class Addnametonation < ActiveRecord::Migration
  def up
  	add_column :nations, :name, :string
  	add_column :nations, :image_src, :string
  end

  def down
  end
end
