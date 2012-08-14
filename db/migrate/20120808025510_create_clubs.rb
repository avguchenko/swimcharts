class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :name
      t.string :short_name
      t.string :code
      t.string :nation
      t.string :type

      t.timestamps
    end
  end
end
