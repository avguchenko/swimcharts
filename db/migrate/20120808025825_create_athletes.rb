class CreateAthletes < ActiveRecord::Migration
  def change
    create_table :athletes do |t|
      t.string :last_name
      t.string :first_name
      t.string :gender
      t.string :birth_date

      t.timestamps
    end
  end
end
