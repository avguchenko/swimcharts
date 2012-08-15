class CreateNations < ActiveRecord::Migration
  def change
    create_table :nations do |t|
      t.string :ioc_code
      t.string :fips_code
      t.timestamps
    end
  end
end
