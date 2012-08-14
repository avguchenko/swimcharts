class AddMd5ToMeets < ActiveRecord::Migration
  def change
  	add_column :meets, :md5, :string
  end
end
