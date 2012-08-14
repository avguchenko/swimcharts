class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :meet_id
      t.integer :number
      t.datetime :session_date
      t.string :daytime

      t.timestamps
    end
  end
end
