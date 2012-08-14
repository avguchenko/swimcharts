class CreateMeets < ActiveRecord::Migration
  def change
    create_table :meets do |t|
      t.string :name
      t.string :city
      t.string :nation
      t.string :course
      t.string :timing

      t.timestamps
    end
  end
end
